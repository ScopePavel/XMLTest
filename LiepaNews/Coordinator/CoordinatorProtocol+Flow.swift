import Foundation

extension CoordinatorProtocol {

    var coordinatorsChain: [CoordinatorProtocol] {
        var coordinators: [CoordinatorProtocol] = []
        var nextCoordinator: CoordinatorProtocol? = self
        while let next = nextCoordinator {
            coordinators.append(next)
            nextCoordinator = next.nextCoordinator
        }
        return coordinators
    }

    func start() {
        switch self.presentationType {
        case .present(let source, let initial):
            guard let sourceController = source, sourceController.presentedViewController == nil else {
                self.resultClosures.onFlowDidFinish(.failure(nil))
                return
            }
            if initial.modalPresentationStyle != .overFullScreen {
                initial.modalPresentationStyle = .fullScreen
            }
            sourceController.present(initial, animated: true, completion: nil)
        case .push(let source, let initial):
            guard let navigationController = source else {
                self.resultClosures.onFlowDidFinish(.failure(nil))
                return
            }
            navigationController.pushViewController(initial, animated: true)
        case .custom:
            return
        }
    }

    func finish(animated: Bool, result: CoordinatorFlowResult, resultClosures: FlowResultClosuresHolder) {
        let closeClosure = {
            resultClosures.onFlowWillFinish?(result)
            switch self.presentationType {
            case .present(_, let initial):
                initial.dismiss(animated: animated) {
                    resultClosures.onFlowDidFinish(result)
                }
            case .push(let source, let initial):
                source?.popToPreviousViewController(of: initial, animated: animated)
                resultClosures.onFlowDidFinish(result)
            case .custom:
                return
            }
        }
        self.finishCoordinatorsUpToFirst(self.coordinatorsChain, animated: animated) {
            closeClosure()
        }
    }

    func finishCoordinatorsUpToFirst(_ coordinators: [CoordinatorProtocol],
                                     animated: Bool,
                                     completion: (() -> Void)? = nil) {
        var coordinators = coordinators
        coordinators.last?.nextCoordinator = nil
        if coordinators.count > 1, let currentCoordinator = coordinators.popLast() {
            let innerResultClosures = FlowResultClosuresHolder { [weak self] _ in
                self?.finishCoordinatorsUpToFirst(coordinators, animated: animated, completion: completion)
            }
            currentCoordinator.finish(animated: animated,
                                      result: .userCancelled,
                                      resultClosures: innerResultClosures)
        } else {
            completion?()
        }
    }
}
