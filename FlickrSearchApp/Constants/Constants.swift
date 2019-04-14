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
    static let flickrSearchTitle = "Flickr Search"
    static let placeholder = "Search Flickr images..."
    
    static let cancel = "Cancel"
    static let ok = "Ok"
    static let retry = "Retry"
    static let error = "Error"
    static let close = "close"
}

//MARK: Numeric Constants
enum Constants {
    static let screenWidth: CGFloat = UIScreen.main.bounds.width
    static let defaultSpacing: CGFloat = 1
    static let numberOfColumns: CGFloat = 3
    static let defaultPageNum: Int = 0
    static let defaultTotalCount: Int = 0
    static let defaultPageSize: Int = 20
}


//MARK: NetworkAPI Constants
enum APIConstants {
    static let flickrAPIBaseURL = "https://api.flickr.com"
    static let flickrAPIKey = "f9890551af4b01eccd3dbfdcef155170"
}
