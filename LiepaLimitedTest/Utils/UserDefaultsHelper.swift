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

    func setValueFor(key: String, value: Bool) {
        UserDefaults.standard.setValue(value, forKey: key)
        NotificationCenter.default.post(name: LLNotifications.parsers,
                                        object: nil,
                                        userInfo: [key: value])
    }

    func getValueFor(key: String) -> Bool {
        if let state = UserDefaults.standard.value(forKey: key) as? Bool {
            return state
        }
        return true
    }

    private enum Constants {
        static let timeIntervalForTimer = "timeIntervalForTimer"
    }
}
