//
//  Router.swift
//  LiepaLimitedTest
//
//  Created by Паронькин Павел on 30.07.2021.
//

import UIKit

final class Router {

    func initRootViewController(parsersConfigurator: ParsersConfigurator, dataBaseManager: DataBaseManagerProtocol) -> UINavigationController? {
        let viewModel = FeedViewModel(parsersConfigurator: parsersConfigurator,
                                      router: self,
                                      dataBaseManager: dataBaseManager)
        if let controller = FeedsBuilder().build(viewModel: viewModel) {
            navigationController = UINavigationController(rootViewController: controller)
        }
        return navigationController
    }

    func showSettings(onClose: @escaping (()->())) {
        let viewModel = SettingViewModel()
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

    private var navigationController = UINavigationController()
}
