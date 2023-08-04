import UIKit

final class SettingBuilder {
    func build(viewModel: SettingViewModel) -> UIViewController? {
        let viewController = SettingViewController()
        viewController.viewModel = viewModel
        return viewController
    }
}
