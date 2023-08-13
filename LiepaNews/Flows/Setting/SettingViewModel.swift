import Foundation

protocol SettingViewModel {
    var timeInterval: Double? { get set }
    var parsersConfigurator: ParsersConfiguratorProtocol { get set }

    func done()
}

final class SettingViewModelImpl: SettingViewModel {

    // MARK: - Internal properties

    var parsersConfigurator: ParsersConfiguratorProtocol
    var timeInterval: Double? = UserDefaultsHelper().timeIntervalForTimer

    // MARK: - Private properties

    private weak var settingsOutput: SettingsOutput?

    // MARK: - Init

    init(settingsOutput: SettingsOutput, parsersConfigurator: ParsersConfiguratorProtocol) {
        self.parsersConfigurator = parsersConfigurator
        self.settingsOutput = settingsOutput
    }

    // MARK: - Public

    func done() {
        let userDefaultsHelper = UserDefaultsHelper()
        userDefaultsHelper.timeIntervalForTimer = timeInterval ?? UserDefaultsHelper().timeIntervalForTimer
        settingsOutput?.userDidFinishFlow()
    }
}

enum LLNotifications {
    static let parsers = Notification.Name("parsers")
}
