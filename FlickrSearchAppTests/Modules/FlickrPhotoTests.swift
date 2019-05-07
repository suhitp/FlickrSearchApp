//
//  FlickrPhotoTests.swift
//  FlickrSearchAppTests
//
//  Created by Suhit Patil on 21/10/18.
//  Copyright © 2018 Suhit Patil. All rights reserved.
//

import XCTest
@testable import FlickrSearchApp

final class FlickrPhotoTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFlickrPhotoEntity() {
        let flickrPhotos = getFlickrPhotos()
        XCTAssertNotNil(flickrPhotos)
        XCTAssertFalse(flickrPhotos.photo.isEmpty)
        
        let photo = flickrPhotos.photo[0]
        XCTAssertTrue(photo.id == "12345")
        XCTAssertEqual(photo.title, "test image title")
        XCTAssertTrue(photo.farm == 2)
    }
    
    func getFlickrPhotos() -> FlickrPhotos {
        let bundle = Bundle(for: type(of: self))
        let fileUrl = bundle.url(forResource: "TestData", withExtension: "json")!
        let data = try! Data(contentsOf: fileUrl)
        let flickrPhotos = try! JSONDecoder().decode(FlickrPhotos.self, from: data)
        return flickrPhotos
    }
}
