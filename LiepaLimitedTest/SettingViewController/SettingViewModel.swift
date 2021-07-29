//
//  SettingViewModel.swift
//  LiepaLimitedTest
//
//  Created by 18529728 on 30.07.2021.
//

import Foundation

final class SettingViewModel {
    var onClose: (()->())?

    var timeInterval: Double?

    func done() {
        let userDefaultsHelper = UserDefaultsHelper()
        if let timeInterval = timeInterval {
            userDefaultsHelper.timeIntervalForTimer = timeInterval
        }

        NotificationCenter.default.post(name: LLNotifications.settings,
                                        object: nil,
                                        userInfo: nil)
        onClose?()
    }
}

struct LLNotifications {
    static let settings = NSNotification.Name.init("settings")
}
