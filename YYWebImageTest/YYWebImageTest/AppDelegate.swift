//
//  AppDelegate.swift
//  YYWebImageTest
//
//  Created by Bruce on 2024/6/7.
//

import UIKit
import YYWebImage
@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let cache = YYWebImageManager.shared().cache
//        cache?.memoryCache.removeAllObjects()
//        cache?.diskCache.removeAllObjects()
        cache?.memoryCache.costLimit = 50 * 1024 * 1024
        cache?.memoryCache.countLimit = 50
        cache?.diskCache.costLimit = 500 * 1024 * 1024
        cache?.diskCache.countLimit = 1500
        cache?.diskCache.ageLimit = 60 * 60 * 24 * 7
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

