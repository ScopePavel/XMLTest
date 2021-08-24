//
//  SettingViewModel.swift
//  LiepaLimitedTest
//
//  Created by Паронькин Павел on 30.07.2021.
//

import Foundation

final class SettingViewModel {
    var onClose: (()->())?
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

struct LLNotifications {
    static let parsers = NSNotification.Name.init("parsers")
}
