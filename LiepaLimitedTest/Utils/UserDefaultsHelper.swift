//
//  UserDefaultsHelper.swift
//  LiepaLimitedTest
//
//  Created by 18529728 on 30.07.2021.
//

import Foundation

final class UserDefaultsHelper {
    var timeIntervalForTimer: Double {
        get {
            if let state = UserDefaults.standard.value(forKey: Constants.timeIntervalForTimer) as? Double {
                return state
            }
            return 2
        }

        set {
            UserDefaults.standard.setValue(newValue, forKey: Constants.timeIntervalForTimer)
        }
    }

    struct Constants {
        static let timeIntervalForTimer = "timeIntervalForTimer"
    }
}
