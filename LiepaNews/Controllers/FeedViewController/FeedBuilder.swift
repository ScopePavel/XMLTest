import UIKit

final class FeedsBuilder {
    static func build(_ feedOutput: FeedOutput, parserConfigModels: ParsersConfigurator) -> UINavigationController {
        let viewController = FeedViewController()
        let dataBaseManager = DataBaseManager()

        let viewModel = FeedViewModelImpl(
            parsersConfigurator: parserConfigModels,
            dataBaseManager: dataBaseManager,
            feedOutput: feedOutput
        )

        viewController.viewModel = viewModel
        return InteractionNavigationController(rootViewController: viewController)
    }
}
