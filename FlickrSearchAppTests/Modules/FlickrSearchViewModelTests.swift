//
//  FlickrSearchViewModelTests.swift
//  FlickrSearchAppTests
//
//  Created by Suhit Patil on 21/10/18.
//  Copyright © 2018 Suhit Patil. All rights reserved.
//

import XCTest
@testable import FlickrSearchApp

class FlickrSearchViewModelTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testViewModelUrlEmptyList() {
        let viewModel = FlickrSearchViewModel(photoUrlList: [])
        XCTAssertTrue(viewModel.isEmpty)
    }
    
    func testViewModelUrlListNotEmpty() {
        var urls: [URL] = []
        for _ in 0...3 {
            let url = URL(string: "https://flickr.static.com/image2/12344_m.jpg")!
            urls.append(url)
        }
        let viewModel = FlickrSearchViewModel(photoUrlList: urls)
        XCTAssertFalse(viewModel.photoUrlList.isEmpty)
        XCTAssertTrue(viewModel.photoCount == 4)
    }
    
    func testAddMorePhoto() {
        var urls: [URL] = []
        for _ in 0...3 {
            let url = URL(string: "https://flickr.static.com/image2/12344_m.jpg")!
            urls.append(url)
        }
        var viewModel = FlickrSearchViewModel(photoUrlList: urls)
        viewModel.addMorePhotosUrls(urls)
        XCTAssertFalse(viewModel.isEmpty)
        XCTAssertTrue(viewModel.photoCount == 8)
    }
}
