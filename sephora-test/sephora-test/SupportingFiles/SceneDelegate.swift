//
//  SceneDelegate.swift
//  sephora-test
//
//  Created by Lau on 06/06/2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var context: Context!
    var mainCoordinator: MainCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let winScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: winScene)
        
        let client = HTTPClient()
        let stack = CoreDataStack(modelName: "sephora_test",
                                  type: .prod)
        context = Context(client: client, stack: stack)
        let screens = Screens(context: context)
        
        mainCoordinator = MainCoordinator(window: window, screens: screens)
        
        mainCoordinator?.start()
    }
}

