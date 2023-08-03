//
//  SettingBuilder.swift
//  LiepaLimitedTest
//
//  Created by Паронькин Павел on 30.07.2021.
//

import UIKit

final class SettingBuilder {
    func build(viewModel: SettingViewModel) -> UIViewController? {
        let viewController = SettingViewController()
        viewController.viewModel = viewModel
        return viewController
    }
}
