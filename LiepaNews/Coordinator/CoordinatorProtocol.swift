import Foundation
import UIKit

protocol CoordinatorProtocol: AnyObject {
    var resultClosures: FlowResultClosuresHolder { get }
    var presentationType: CoordinatorPresentationType { get }
    var nextCoordinator: CoordinatorProtocol? { get set }

    func start()
    func finish(animated: Bool, result: CoordinatorFlowResult, resultClosures: FlowResultClosuresHolder)
}

extension CoordinatorProtocol {
    func mixInCoordinatorRelease(_ resultClosures: FlowResultClosuresHolder) -> FlowResultClosuresHolder {
        return resultClosures.before(.didFinish) { [weak self] in
            self?.nextCoordinator = nil
        }
    }
}
