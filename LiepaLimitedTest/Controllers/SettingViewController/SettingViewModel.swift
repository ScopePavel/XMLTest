//
//  SettingViewModel.swift
//  LiepaLimitedTest
//
//  Created by Паронькин Павел on 30.07.2021.
//

import Foundation

final class SettingViewModel {
    var onClose: (()->())?

    var isGazeta: Bool = UserDefaultsHelper().isGazeta
    var isLenta: Bool = UserDefaultsHelper().isLenta
    var timeInterval: Double? = UserDefaultsHelper().timeIntervalForTimer

    func done() {
        let userDefaultsHelper = UserDefaultsHelper()
        userDefaultsHelper.timeIntervalForTimer = timeInterval ?? UserDefaultsHelper().timeIntervalForTimer
        UserDefaultsHelper().isGazeta = isGazeta
        UserDefaultsHelper().isLenta = isLenta

        NotificationCenter.default.post(name: LLNotifications.settings,
                                        object: nil,
                                        userInfo: nil)
        onClose?()
    }
}

struct LLNotifications {
    static let settings = NSNotification.Name.init("settings")
    static let parsers = NSNotification.Name.init("parsers")
}
