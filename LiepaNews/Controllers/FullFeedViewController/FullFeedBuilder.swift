import UIKit

final class FullFeedBuilder {
    static func build(fullFeedOutput: FullFeedOutput, feedCellViewModel: FeedCellViewModel) -> UIViewController {
        let viewController = FullFeedViewController()
        let viewModel = FullFeedViewModelImpl(fullFeedOutput: fullFeedOutput, model: feedCellViewModel)
        viewController.viewModel = viewModel
        return viewController
    }
}
