//
//  AppDelegate.swift
//  FlickrSearchApp
//
//  Created by Suhit Patil on 28/09/18.
//  Copyright © 2018 Suhit Patil. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureURLCache()
        window = UIWindow(frame: UIScreen.main.bounds)
        AppConfigurator().configureRootViewController(inWindow: window)
        return true
    }
    
    /// Configure URLCache for Image Caching
    fileprivate func configureURLCache() {
        let memoryCapacity = 1000 * 1024 * 1024 // 1 GB Memory Cache
        let diskCapacity = 1000 * 1024 * 1024 // 1 GB Disk Cache
        let cache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: "DataCachePath")
        URLCache.shared = cache
    }

}

