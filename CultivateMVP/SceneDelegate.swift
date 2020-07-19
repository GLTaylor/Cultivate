//
//  SceneDelegate.swift
//  CultivateMVP
//
//  Created by Taylor Lindsay on 3/23/20.
//  Copyright © 2020 Taylor Lindsay. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var sceneCoordinator: SceneCoordinatorType!

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        let sceneFactory = SceneFactory()
        sceneCoordinator = SceneCoordinator(window: window!, factory: sceneFactory)
        sceneFactory.setup(with: sceneCoordinator)

        sceneCoordinator.transition(to: Scene.thoughtOfDay, type: .root)
    }
}
