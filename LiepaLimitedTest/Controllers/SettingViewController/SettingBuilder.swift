//
//  SettingBuilder.swift
//  LiepaLimitedTest
//
//  Created by Паронькин Павел on 30.07.2021.
//

import UIKit

final class SettingBuilder {
    func build(viewModel: SettingViewModel) -> SettingViewController? {
        let viewController = UIStoryboard(name: "Setting", bundle: Bundle(for: type(of: self))).instantiateInitialViewController() as? SettingViewController
        viewController?.viewModel = viewModel
        return viewController
    }
}
