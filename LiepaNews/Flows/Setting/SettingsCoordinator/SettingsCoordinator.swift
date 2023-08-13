import Foundation
import UIKit

protocol SettingsOutput: AnyObject {
    func userDidFinishFlow()
}

final class SettingsCoordinator: CoordinatorProtocol {

    // MARK: - Coordinator Protocol

    let resultClosures: FlowResultClosuresHolder
    var nextCoordinator: CoordinatorProtocol?
    var presentationType: CoordinatorPresentationType {
        .present(source: self.sourceViewController, initial: self.initialViewController)
    }

    private let sourceViewController: UIViewController
    private let parsersConfigurator: ParsersConfigurator
    private lazy var initialViewController = SettingBuilder.build(
        self,
        parsersConfigurator: parsersConfigurator
    )

    // MARK: - Init

    init(
        sourceViewController: UIViewController,
        parsersConfigurator: ParsersConfigurator,
        resultClosures: FlowResultClosuresHolder
    ) {
        self.sourceViewController = sourceViewController
        self.parsersConfigurator = parsersConfigurator
        self.resultClosures = resultClosures
    }
}

// MARK: - SettingsOutput

extension SettingsCoordinator: SettingsOutput {
    func userDidFinishFlow() {
        self.finish(animated: true, result: .userCancelled, resultClosures: self.resultClosures)
    }
}

extension CoordinatorProtocol {

    func startSettingsCoordinator(
        sourceViewController: UIViewController,
        parsersConfigurator: ParsersConfigurator,
        resultClosures: FlowResultClosuresHolder = .empty
    ) {
        self.nextCoordinator = SettingsCoordinator(
            sourceViewController: sourceViewController,
            parsersConfigurator: parsersConfigurator,
            resultClosures: self.mixInCoordinatorRelease(resultClosures)
        )
        self.nextCoordinator?.start()
    }
}
