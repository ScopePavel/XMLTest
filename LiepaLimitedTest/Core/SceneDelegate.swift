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
}

