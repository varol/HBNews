//
//  SceneDelegate.swift
//  HBNews
//
//  Created by Varol AKSOY on 30.07.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let windowScene = UIWindowScene(session: session, connectionOptions: connectionOptions)
        self.window = UIWindow(windowScene: windowScene)
        let viewController = SplashRouter.setupModule()
        self.window?.rootViewController = viewController
        self.window?.makeKeyAndVisible()
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }


}

