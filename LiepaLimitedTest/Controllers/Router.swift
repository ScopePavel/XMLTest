import UIKit

final class Router {

    private var navigationController = UINavigationController()

    func initRootViewController(
        parsersConfigurator: ParsersConfigurator,
        dataBaseManager: DataBaseManagerProtocol
    ) -> UINavigationController? {
        let viewModel = FeedViewModelImpl(
            parsersConfigurator: parsersConfigurator,
            router: self,
            dataBaseManager: dataBaseManager
        )
        if let controller = FeedsBuilder().build(viewModel: viewModel) {
            navigationController = UINavigationController(rootViewController: controller)
        }
        return navigationController
    }

    func showSettings(parsersConfigurator: ParsersConfiguratorProtocol, onClose: @escaping (() -> Void)) {
        let viewModel = SettingViewModelImpl(parsersConfigurator: parsersConfigurator)
        viewModel.onClose = { [weak self] in
            onClose()
            self?.navigationController.dismiss(animated: true, completion: nil)
        }

        if let settings = SettingBuilder().build(viewModel: viewModel) {
            settings.modalPresentationStyle = .overFullScreen
            navigationController.present(settings, animated: true, completion: nil)
        }
    }

    func showFullFeed(feedCellViewModel: FeedCellViewModel) {
        if let vc = FullFeedBuilder().build(feedCellViewModel: feedCellViewModel) {
            navigationController.pushViewController(vc, animated: true)
        }
    }
}
