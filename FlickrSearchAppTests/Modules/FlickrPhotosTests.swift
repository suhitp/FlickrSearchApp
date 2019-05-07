//
//  FlickrPhotosTests.swift
//  FlickrSearchAppTests
//
//  Created by Suhit Patil on 21/10/18.
//  Copyright © 2018 Suhit Patil. All rights reserved.
//

import XCTest
@testable import FlickrSearchApp

final class FlickrPhotosTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    //MARK: Test sample response mapping to FlickrPhotos
    func testFlickrPhotosJSONDecoder() {
        let bundle = Bundle(for: type(of: self))
        let fileUrl = bundle.url(forResource: "TestData", withExtension: "json")!
        let data = try! Data(contentsOf: fileUrl)
        let flickrPhotos = try! JSONDecoder().decode(FlickrPhotos.self, from: data)
        XCTAssertFalse(flickrPhotos.photo.isEmpty)
        XCTAssertTrue(flickrPhotos.photo.count == 2)
        XCTAssertTrue(flickrPhotos.page == 1)
        XCTAssertTrue(flickrPhotos.total == "2")
        XCTAssertTrue(flickrPhotos.perpage == 20)
    }
}
