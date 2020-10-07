//
//  SceneDelegate.swift
//  CultivateMVP
//
//  Created by Taylor Lindsay on 3/23/20.
//  Copyright © 2020 Taylor Lindsay. All rights reserved.
//
//
//import UIKit
//
//class SceneDelegate: UIResponder, UIWindowSceneDelegate {
//
//    var window: UIWindow?
//    var sceneCoordinator: SceneCoordinatorType!
//
//    func scene(_ scene: UIScene,
//               willConnectTo session: UISceneSession,
//               options connectionOptions: UIScene.ConnectionOptions) {
//
//        let sceneFactory = SceneFactory()
//        sceneCoordinator = SceneCoordinator(window: window!, factory: sceneFactory)
//        sceneFactory.setup(with: sceneCoordinator)
//
//        sceneCoordinator.transition(to: Scene.thoughtOfDay, type: .root)
//    }
//}
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        let contentView = TabBarView(store: AppStore(initialState: AppState(), reducer: reducer))

//        let contentView = ThoughtOfDayView(store: AppStore(initialState: AppState(), reducer: reducer))

        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}
