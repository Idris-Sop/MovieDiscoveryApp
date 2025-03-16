//
//  SceneDelegate.swift
//  MovieApp
//
//  Created by Idris Jovial SOP NWABO.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let navigationController = DependencyContainer.navigationController
        let movieCoordinator = DependencyContainer.movieCoordinator
        let loginCoordinator = DependencyContainer.loginCoordinator
        let sensitiveStorage = DependencyContainer.sensitiveStorageRepository
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = navigationController.initalController
        
        loginCoordinator.initalRootViewController()
        
        if(sensitiveStorage.isAccessTokenStored()) {
            movieCoordinator.initalRootViewController()
        } else {
            loginCoordinator.initalRootViewController()
        }
               
        self.window = window
        
        window.makeKeyAndVisible()
    }
}

