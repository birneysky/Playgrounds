//
//  AppDelegate.swift
//  SDWebImageTest
//
//  Created by Bruce on 2024/6/6.
//

import UIKit
import SDWebImage
import SDWebImageWebPCoder
@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        let cacheConfig = SDImageCacheConfig()
//        cacheConfig.maxMemoryCost = 50 * 1024 * 1024 // 最大内存使用限制为50MB
//        cacheConfig.maxMemoryCount = 100 // 最大缓存图片数量
//
//        let imageCache = SDImageCache(namespace: "your_namespace", config: cacheConfig)
//        SDImageCache.shared.config = cacheConfig
        // Override point for customization after application launch.
        SDImageCache.shared.config.maxMemoryCost = 80 * 1024 * 1024
        SDImageCache.shared.config.maxMemoryCount = 120
        SDWebImageDownloader.shared.config.executionOrder = .lifoExecutionOrder
//        [SDWebImageDownloader sharedDownloader].config.executionOrder = SDWebImageDownloaderLIFOExecutionOrder;
        if #available(iOS 14, tvOS 14, macOS 11, watchOS 7, *) {
        // iOS 14 supports WebP built-in
            SDImageCodersManager.shared.addCoder(SDImageAWebPCoder.shared)
        } else {
        // iOS 13 does not support WebP, use third-party codec
            SDImageCodersManager.shared.addCoder(SDImageWebPCoder.shared)
        }

        if #available(iOS 13, tvOS 13, macOS 10.15, watchOS 6, *) {
        // For HEIC animated image. Animated image is newly introduced in iOS 13, but it contains performance issues for now.
            SDImageCodersManager.shared.addCoder(SDImageHEICCoder.shared)
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

