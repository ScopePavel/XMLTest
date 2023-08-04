import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)

        let parserConfigModels = [
            ParsersConfiguratorModel(parser: ParserManagerTwo(id: "http://lenta.ru/rss")),
            ParsersConfiguratorModel(parser: ParserManagerTwo(id: "http://www.gazeta.ru/export/rss/lenta.xml")),
            ParsersConfiguratorModel(parser: ParserManagerTwo(id: "https://meduza.io/rss/all"))
        ]

        let rootViewController = Router().initRootViewController(
            parsersConfigurator: ParsersConfigurator(models: parserConfigModels),
            dataBaseManager: DataBaseManager()
        )
        window.rootViewController = rootViewController

        self.window = window
        window.makeKeyAndVisible()

        guard let _ = (scene as? UIWindowScene) else { return }
    }
}
