//
//  MockNetworkClient.swift
//  FlickrSearchAppTests
//
//  Created by Suhit Patil on 21/10/18.
//  Copyright © 2018 Suhit Patil. All rights reserved.
//

import Foundation
import UIKit
@testable import FlickrSearchApp

final class NetworkClientMock: NetworkService {
    
    func dataRequest<T>(_ endPoint: APIEndPoint, objectType: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) -> URLSessionDataTask where T : Decodable {
        if case FlickrSearchAPI.search(query: "nature", page: 1) = endPoint {
            let bundle = Bundle(for: type(of: self))
            let fileUrl = bundle.url(forResource: "TestData", withExtension: "json")!
            let data = try! Data(contentsOf: fileUrl)
            let json = try! JSONDecoder().decode(objectType, from: data)
            completion(Result.success(json))
        } else if case FlickrSearchAPI.search(query: "nature", page: -1) = endPoint {
            completion(Result.failure(.invalidStatusCode(401)))
        } else if case FlickrSearchAPI.search(query: "dfdfdf", page: 1) = endPoint {
            completion(Result.failure(.emptyData))
        }
        return URLSessionDataTask()
    }
    
    func downloadRequest(_ url: URL, size: CGSize, scale: CGFloat, completion: @escaping (Result<UIImage, NetworkError>) -> Void) -> URLSessionDownloadTask {
        if url.absoluteString == "https://farm2.static.flickr.com/100/12345_/12345.jpg" {
            let image = UIImage(color: .black)!
            completion(Result.success(image))
        } else {
            completion(Result.failure(.somethingWentWrong))
        }
        
        return URLSessionDownloadTask()
    }
}
