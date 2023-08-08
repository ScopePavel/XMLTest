import Foundation
import UIKit

protocol FullFeedOutput: AnyObject {
    func userDidFinishFlow()
}

final class FullFeedCoordinator: CoordinatorProtocol {

    // MARK: - Internal properties

    let resultClosures: FlowResultClosuresHolder
    var nextCoordinator: CoordinatorProtocol?
    var presentationType: CoordinatorPresentationType {
        .push(source: self.sourceViewController, initial: self.initialViewController)
    }

    // MARK: - Private properties

    private let sourceViewController: UINavigationController
    private lazy var initialViewController = FullFeedBuilder.build(fullFeedOutput: self, feedCellViewModel: self.model)
    private let model: FeedCellViewModel

    // MARK: - Init

    init(
        model: FeedCellViewModel,
        sourceViewController: UINavigationController,
        resultClosures: FlowResultClosuresHolder
    ) {
        self.model = model
        self.sourceViewController = sourceViewController
        self.resultClosures = resultClosures
    }
}

// MARK: - FullFeedOutput

extension FullFeedCoordinator: FullFeedOutput {
    func userDidFinishFlow() {
        self.finish(animated: true, result: .userCancelled, resultClosures: self.resultClosures)
    }
}

extension CoordinatorProtocol {

    func startDetailedNewsCoordinator(model: FeedCellViewModel,
                                      sourceViewController: UINavigationController,
                                      resultClosures: FlowResultClosuresHolder = .empty) {
        self.nextCoordinator = FullFeedCoordinator(
            model: model,
            sourceViewController: sourceViewController,
            resultClosures: self.mixInCoordinatorRelease(resultClosures)
        )
        self.nextCoordinator?.start()
    }
}
