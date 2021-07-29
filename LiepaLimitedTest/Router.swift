//
//  Router.swift
//  LiepaLimitedTest
//
//  Created by 18529728 on 30.07.2021.
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


    private let navigationController: UINavigationController
}
