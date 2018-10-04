//
//  Constants.swift
//  FlickrSearchApp
//
//  Created by Suhit Patil on 02/10/18.
//  Copyright © 2018 Suhit Patil. All rights reserved.
//

import Foundation
import UIKit

//MARK: String Constants
enum Strings {
    static let searchPageTitle = "Flickr Search"
    static let reuseIdentifier = "FlickrImageCell"
    static let placeholder = "Search Flickr images..."
    
    static let flickrAPIBaseURL = "https://api.flickr.com"
    static let flickrAPIKey = "3e7cc266ae2b0e0d78e279ce8e361736" //"f9890551af4b01eccd3dbfdcef155170"
}

//MARK: Numeric Constants
enum Constants {
    static let screenWidth: CGFloat = UIScreen.main.bounds.width
    static let defaultSpacing: CGFloat = 1
    static let numberOfColumns: CGFloat = 3
    static let defaultPageNum: Int = 0
    static let defaultTotalCount: Int = 0
}


