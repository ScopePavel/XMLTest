import UIKit

enum NavigationInteractionMethod {
    case backButtonTap
    case popGesture
}

protocol NavigationInteractionDependable: AnyObject {
    func viewControllerIsRemovingBy(_ navigationInteractionMethod: NavigationInteractionMethod)
}

class InteractionNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }

    private func detectRemoving(coordinator: UIViewControllerTransitionCoordinator,
                                navigationInteractionMethod: NavigationInteractionMethod) {
        let fromVC = coordinator.viewController(forKey: UITransitionContextViewControllerKey.from)
        if let viewController = fromVC as? NavigationInteractionDependable {
            viewController.viewControllerIsRemovingBy(navigationInteractionMethod)
        }
    }
}

extension InteractionNavigationController: UINavigationControllerDelegate {

    func navigationController(
        _ navigationController: UINavigationController,
        willShow viewController: UIViewController,
        animated: Bool
    ) {
        if let coordinator = self.topViewController?.transitionCoordinator {
            if !coordinator.isInteractive {
                if coordinator.isCancelled {
                    return
                }
                self.detectRemoving(coordinator: coordinator, navigationInteractionMethod: .backButtonTap)
                return
            }
            coordinator.notifyWhenInteractionChanges { [weak self] context in
                if context.isCancelled {
                    return
                }
                self?.detectRemoving(coordinator: coordinator, navigationInteractionMethod: .popGesture)
            }
        }
    }
}
