import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        let applicationCoordinator = ApplicationCoordinator(window: window)
        self.window = window
        self.window?.windowScene = windowScene
//        SourcesManager.shared.start()
//        UpdateTimerManager.shared.start()
        applicationCoordinator.start()
    }
}
