//
//  SceneDelegate.swift
//  SocketChatting
//
//  Created by 강조은 on 2023/10/31.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = LoginNC()
        window.makeKeyAndVisible()
        self.window = window
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        SocketIOManager.instance.establishConnection()

    }
    
    func changeRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard let window = self.window else { return }
        window.rootViewController = vc
    }
}
