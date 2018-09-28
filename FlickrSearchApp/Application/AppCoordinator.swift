//
//  ApplicationRouter.swift
//  FlickrSearchApp
//
//  Created by Suhit Patil on 28/09/18.
//  Copyright © 2018 Suhit Patil. All rights reserved.
//

import UIKit

final public class AppCoordinator {
    
    @discardableResult
    func configureRootViewController(inWindow window: UIWindow?) -> Bool {
        let flickrSearchViewController = FlickrSearchModuleBuilder().buildModule()
        let navigationController = UINavigationController(rootViewController: flickrSearchViewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
}
