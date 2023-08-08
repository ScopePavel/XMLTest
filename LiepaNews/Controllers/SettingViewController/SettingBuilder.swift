import UIKit

final class SettingBuilder {
    static func build(
        _ settingsOutput: SettingsOutput,
        parsersConfigurator: ParsersConfiguratorProtocol
    ) -> UIViewController {
        let viewController = SettingViewController()
        viewController.viewModel = SettingViewModelImpl(
            settingsOutput: settingsOutput,
            parsersConfigurator: parsersConfigurator
        )
        return viewController
    }
}
