//
//  AppDelegate.swift
//  Snake
//
//  Created by Albert Mercadé on 18/06/2020.
//  Copyright © 2020 Albert Mercadé. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if (!UserDefaults.standard.bool(forKey: "HasLaunchedOnce")) {
           // First app launch
            UserDefaults.standard.set(0, forKey: "highScore")
            UserDefaults.standard.set(0.2, forKey: "snakeSpeed")
            UserDefaults.standard.set(true, forKey: "HasLaunchedOnce")
            UserDefaults.standard.synchronize()
            UserDefaults.standard.set(UIColor.green, forKey: "snakeColor")
            UserDefaults.standard.set(0, forKey: "gameMode")
            UserDefaults.standard.set(false, forKey: "wallsInGrid")
        }
        
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

