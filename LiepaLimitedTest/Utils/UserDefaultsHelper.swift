//
//  UserDefaultsHelper.swift
//  LiepaLimitedTest
//
//  Created by Паронькин Павел on 30.07.2021.
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

    var isLenta: Bool {
        get {
            if let state = UserDefaults.standard.value(forKey: Constants.lenta) as? Bool {
                return state
            }
            return true
        }

        set {
            UserDefaults.standard.setValue(newValue, forKey: Constants.lenta)
            NotificationCenter.default.post(name: LLNotifications.parsers,
                                            object: nil,
                                            userInfo: [ParserIds.lenta.rawValue : newValue])
        }
    }

    var isGazeta: Bool {
        get {
            if let state = UserDefaults.standard.value(forKey: Constants.gazeta) as? Bool {
                return state
            }
            return true
        }

        set {
            UserDefaults.standard.setValue(newValue, forKey: Constants.gazeta)
            NotificationCenter.default.post(name: LLNotifications.parsers,
                                            object: nil,
                                            userInfo: [ParserIds.gazeta.rawValue : newValue])
        }
    }

    private struct Constants {
        static let timeIntervalForTimer = "timeIntervalForTimer"
        static let lenta = "lenta"
        static let gazeta = "gazeta"
    }
}
