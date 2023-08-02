//
//  SettingViewModel.swift
//  LiepaLimitedTest
//
//  Created by Паронькин Павел on 30.07.2021.
//

import Foundation

protocol SettingViewModel {
    var onClose: (() -> Void)? { get set }
    var timeInterval: Double? { get set }
    var parsersConfigurator: ParsersConfiguratorProtocol { get set }

    func done()
}

final class SettingViewModelImpl: SettingViewModel {
    var onClose: (() -> Void )?
    var parsersConfigurator: ParsersConfiguratorProtocol
    var timeInterval: Double? = UserDefaultsHelper().timeIntervalForTimer

    init(parsersConfigurator: ParsersConfiguratorProtocol) {
        self.parsersConfigurator = parsersConfigurator
    }

    func done() {
        let userDefaultsHelper = UserDefaultsHelper()
        userDefaultsHelper.timeIntervalForTimer = timeInterval ?? UserDefaultsHelper().timeIntervalForTimer
        onClose?()
    }
}

enum LLNotifications {
    static let parsers = Notification.Name("parsers")
}
