//
//  FlickrSearchAPI.swift
//  FlickrSearchApp
//
//  Created by Suhit Patil on 02/10/18.
//  Copyright © 2018 Suhit Patil. All rights reserved.
//

import Foundation


enum FlickrSearchAPI: APIEndPoint, URLRequestConvertible {
    
    case search(query: String, page: Int)

}

extension FlickrSearchAPI {
    
    var baseURL: URL {
        return URL(string: APIConstants.flickrAPIBaseURL)!
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        return "/services/rest/"
    }
    
    var parameters: [String : Any] {
        switch self {
        case let .search(query, page):
            return [
                "method": "flickr.photos.search",
                "api_key": APIConstants.flickrAPIKey,
                "format": "json",
                "nojsoncallback": 1,
                "safe_search": 1,
                "text": query,
                "page": page,
                "per_page": Constants.defaultPageSize
            ]
        }
    }
    
}
