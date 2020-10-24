//
//  UINavigationController+Extensions.swift
//  FlickrSearchApp
//
//  Created by Suhit Patil on 24/10/20.
//  Copyright © 2020 Suhit Patil. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    func themeNavigationBar() {
        navigationBar.prefersLargeTitles = true
        navigationBar.tintColor = UIColor.tintColor
        let titleTextAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.navigationTitleColor
        ]
        navigationBar.titleTextAttributes = titleTextAttributes
        navigationBar.largeTitleTextAttributes = titleTextAttributes
    }
    
}
