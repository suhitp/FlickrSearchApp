//
//  UIColor+Extensions.swift
//  FlickrSearchApp
//
//  Created by Suhit Patil on 24/10/20.
//  Copyright © 2020 Suhit Patil. All rights reserved.
//

import UIKit

extension UIColor {
    
    /// backgroundColor
    static var backgroundColor: UIColor {
        if #available(iOS 13, *), UIScreen.main.isDarkMode {
            return .systemBackground
        } else {
            return .white
        }
    }
    
    static var navigationTitleColor: UIColor {
        if #available(iOS 13, *), UIScreen.main.isDarkMode {
            return .label
        } else {
            return .black
        }
    }
    
    static var tintColor: UIColor {
        if #available(iOS 13, *), UIScreen.main.isDarkMode {
            return .white
        } else {
            return .black
        }
    }
    
    static var footerColor: UIColor {
        if #available(iOS 13, *), UIScreen.main.isDarkMode {
            return .black
        } else {
            return .white
        }
    }
    
    static var placeholder: UIColor {
        if #available(iOS 13, *), UIScreen.main.isDarkMode {
            return UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1)
        } else {
            return .black
        }
    }
    
    static var activityIndicatorColor: UIColor {
        if #available(iOS 13, *), UIScreen.main.isDarkMode {
            return .white
        } else {
            return .black
        }
    }
    
}


extension UIScreen {
    var isDarkMode: Bool {
        if #available(iOS 13.0, *) {
            switch UITraitCollection.current.userInterfaceStyle {
            case .light, .unspecified:
                return false
            case .dark:
                return true
            @unknown default:
                return false
            }
        } else {
            return false
        }
    }
}
