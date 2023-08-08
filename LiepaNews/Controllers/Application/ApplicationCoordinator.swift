import Foundation
import UIKit

final class ApplicationCoordinator: CoordinatorProtocol {

    // MARK: - Internal properties

    var rootController: UIViewController { self.navBarCoordinator.newslineModule }
    var presentationType: CoordinatorPresentationType { .custom }
    var nextCoordinator: CoordinatorProtocol?
    private(set) var resultClosures: FlowResultClosuresHolder = .empty
    lazy var navBarCoordinator = FeedCoordinator()

    // MARK: - Private properties

    private let window: UIWindow

    // MARK: - Init

    init(window: UIWindow) {
        self.window = window
    }

    // MARK: - Flow

    func start() {
        self.nextCoordinator = self.navBarCoordinator
        self.window.rootViewController = self.rootController
        self.window.makeKeyAndVisible()
    }

    func finish(
        animated: Bool,
        result: CoordinatorFlowResult,
        resultClosures: FlowResultClosuresHolder
    ) { }
}
