import UIKit

final class FeedsBuilder {
    func build(viewModel: FeedViewModel) -> UIViewController? {
        let viewController = FeedViewController()
        viewController.viewModel = viewModel
        return viewController
    }
}
