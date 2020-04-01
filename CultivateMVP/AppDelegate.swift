//
//  AppDelegate.swift
//  CultivateMVP
//
//  Created by Taylor Lindsay on 3/23/20.
//  Copyright © 2020 Taylor Lindsay. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    //I will probably match up dependencies in here. 

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let firstThought = Thought(text: "The journey of a thousand miles begins with a single step")
        let vcFactory = SceneFactory(thoughtOfDayViewModel: ThoughtOfDayViewModel(thoughtOfDay: firstThought), journalOptionsViewModel: JournalOptionsViewModel(entries: [], moodEntry: MoodEntry(moodQuestion: "What's your mood", moodRating: 0)))
        let sceneCoordinator = SceneCoordinator(window: window!, factory: vcFactory)

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

