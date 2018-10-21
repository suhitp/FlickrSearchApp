//
//  NetworkingTests.swift
//  FlickrSearchAppTests
//
//  Created by Suhit Patil on 21/10/18.
//  Copyright © 2018 Suhit Patil. All rights reserved.
//

import XCTest
@testable import FlickrSearchApp

class NetworkingTests: XCTestCase {

    var network: NetworkService!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        network = MockNetworkClient()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        network = nil
    }

    func testNetworkDataRequestSuccess() {
        _ = network.dataRequest(FlickrSearchAPI.search(query: "nature", page: 1), objectType: FlickrPhotos.self, completion: { (result) in
            switch result {
            case let .success(photos):
                XCTAssertTrue(photos.photo.count == 2)
                XCTAssertFalse(photos.page == 0)
            case .failure:
                break
            }
        })
    }
    
    func testNetworkDataRequestInvalidStatusFailure() {
        _ = network.dataRequest(FlickrSearchAPI.search(query: "abc", page: -1), objectType: FlickrPhotos.self, completion: { (result) in
            switch result {
            case .success:
                XCTFail("Should fail with error")
            case let .failure(error):
                XCTAssertTrue(error.description == "Server is down with status code: 401")
            }
        })
    }
    
    func testNetworkDataRequestEmptyDataFailure() {
        _ = network.dataRequest(FlickrSearchAPI.search(query: "dfdfdf", page: 1), objectType: FlickrPhotos.self, completion: { (result) in
            switch result {
            case .success:
                XCTFail("Should fail with error")
            case let .failure(error):
                XCTAssertTrue(error.description == "Empty response from the server")
            }
        })
    }

    func testImageDownloadSuccess() {
        let imageUrl = URL(string: "https://farm2.static.flickr.com/100/12345_/12345.jpg")!
        _ = network.downloadRequest(imageUrl, size: .zero, scale: 1, completion: { (result) in
            switch result {
            case let .success(image):
                XCTAssertFalse(image == UIImage(color: .black))
            case .failure:
                XCTFail("Should go to success")
            }
        })
    }
    
    func testImageDownloadFailure() {
        let imageUrl = URL(string: "https://farm2.static.flickr.com/101/123_/123.jpg")!
        _ = network.downloadRequest(imageUrl, size: .zero, scale: 1, completion: { (result: Result<UIImage>) in
            switch result {
            case let .failure(networkError):
                 XCTAssertTrue(networkError.description == "Something went wrong.")
            case .success:
                XCTFail("Should go to failure")
            }
        })
    }
}


class MockNetworkClient: NetworkService {
    
    func dataRequest<T>(_ endPoint: APIEndPoint, objectType: T.Type, completion: @escaping (Result<T>) -> Void) -> URLSessionDataTask where T : Decodable {
        if case FlickrSearchAPI.search(query: "nature", page: 1) = endPoint {
            let bundle = Bundle(for: type(of: self))
            let fileUrl = bundle.url(forResource: "TestData", withExtension: "json")!
            let data = try! Data(contentsOf: fileUrl)
            let json = try! JSONDecoder().decode(objectType, from: data)
            completion(Result.success(json))
        } else if case FlickrSearchAPI.search(query: "abc", page: -1) = endPoint {
           completion(Result.failure(.invalidStatusCode(401)))
        } else if case FlickrSearchAPI.search(query: "dfdfdf", page: 1) = endPoint {
            completion(Result.failure(.emptyData))
        }
        return URLSessionDataTask()
    }
    
    func downloadRequest(_ url: URL, size: CGSize, scale: CGFloat, completion: @escaping (Result<UIImage>) -> Void) -> URLSessionDownloadTask {
        if url.absoluteString == "https://farm2.static.flickr.com/100/12345_/12345.jpg" {
            let image = UIImage(color: .black)!
            completion(Result.success(image))
        } else {
            completion(Result.failure(.somethingWentWrong))
        }
        
        return URLSessionDownloadTask()
    }
}
