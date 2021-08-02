//
//  Router.swift
//  LiepaLimitedTest
//
//  Created by Паронькин Павел on 30.07.2021.
//

import UIKit

final class Router {
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func showSettings() {
        let viewModel = SettingViewModel()
        viewModel.onClose = { [weak self] in
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

    private let navigationController: UINavigationController
}
