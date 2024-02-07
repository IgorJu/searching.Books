//
//  SceneDelegate.swift
//  searching.Books
//
//  Created by Igor on 07.02.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    let coordinator = SearchCoordinator(networkManager: NetworkManager(), storageManager: StorageManager())
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = UINavigationController()
        
        coordinator.showSearchScreen(in: window.rootViewController as! UINavigationController)
        self.window = window
        window.makeKeyAndVisible()
    }
}
