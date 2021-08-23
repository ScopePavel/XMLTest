//
//  SceneDelegate.swift
//  LiepaLimitedTest
//
//  Created by Паронькин Павел on 28.07.2021.
//

import UIKit


class ArticleListViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        let label = UILabel()
        label.text = "test"
        view.addSubview(label)
    }
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }


        let window = UIWindow(windowScene: windowScene)


        let parserConfigModels = [
            ParsersConfiguratorModel(parser: ParserManagerTwo(id: .lenta,
                                                              urlString: "http://lenta.ru/rss"),
                                     isOn: UserDefaultsHelper().isLenta),
            ParsersConfiguratorModel(parser: ParserManagerTwo(id: .gazeta,
                                                              urlString: "http://www.gazeta.ru/export/rss/lenta.xml"),
                                     isOn: UserDefaultsHelper().isGazeta)
        ]


        let rootViewController = Router().initRootViewController(parsersConfigurator: ParsersConfigurator(models: parserConfigModels),
                                                             dataBaseManager: DataBaseManager())
        window.rootViewController = rootViewController

        self.window = window
        window.makeKeyAndVisible()

        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

