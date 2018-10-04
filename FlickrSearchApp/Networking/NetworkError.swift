//
//  NetworkError.swift
//  FlickrSearchApp
//
//  Created by Suhit Patil on 02/10/18.
//  Copyright © 2018 Suhit Patil. All rights reserved.
//

import Foundation


enum NetworkError: Swift.Error, CustomStringConvertible {
    case apiError(Swift.Error)
    case invalidStatusCode(Int)
    case emptyData
    case invalidRequestURL(URL)
    case decodingError(DecodingError)
    case somethingWentWrong
    
    public var description: String {
        switch self {
        case let .apiError(error):
            return "Network Error: \(error.localizedDescription)"
        case let .decodingError(decodingError):
            return "Json Decoding Error: \(decodingError.localizedDescription)"
        case .emptyData:
            return "Empty repsonse from the server"
        case let .invalidRequestURL(url):
            return "Invalid URL. Please check the endPoint: \(url.absoluteString)"
        case .somethingWentWrong:
            return "Something went wrong."
        case let .invalidStatusCode(status):
            return "Server is down with status code: \(status)"
        }
    }
}
