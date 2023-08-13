import Foundation

protocol SettingViewModel {
    var timeInterval: Double? { get set }
    var urls: [String] { get }

    func done()
}

final class SettingViewModelImpl: SettingViewModel {

    // MARK: - Internal properties

    var urls: [String] {
        parsersConfigurator.allParsers().map { $0.url }
    }
    var timeInterval: Double? = UserDefaultsHelper.shared.timeIntervalForTimer

    // MARK: - Private properties

    private weak var settingsOutput: SettingsOutput?
    private var parsersConfigurator: ParsersConfiguratorProtocol

    // MARK: - Init

    init(settingsOutput: SettingsOutput, parsersConfigurator: ParsersConfiguratorProtocol) {
        self.parsersConfigurator = parsersConfigurator
        self.settingsOutput = settingsOutput
    }

    // MARK: - Public

    func done() {
        let userDefaultsHelper = UserDefaultsHelper.shared
        userDefaultsHelper.timeIntervalForTimer = timeInterval ?? UserDefaultsHelper.shared.timeIntervalForTimer
        settingsOutput?.userDidFinishFlow()
    }
}

enum LLNotifications {
    static let parsers = Notification.Name("parsers")
}
