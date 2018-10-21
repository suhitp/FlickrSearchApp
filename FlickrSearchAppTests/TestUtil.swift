//
//  TestUtil.swift
//  FlickrSearchAppTests
//
//  Created by Suhit Patil on 21/10/18.
//  Copyright © 2018 Suhit Patil. All rights reserved.
//

import XCTest
@testable import FlickrSearchApp

class TestUtil {
     func getFlickrPhotos() -> FlickrPhotos {
        let bundle = Bundle(for: type(of: self))
        let fileUrl = bundle.url(forResource: "TestData", withExtension: "json")!
        let data = try! Data(contentsOf: fileUrl)
        let flickrPhotos = try! JSONDecoder().decode(FlickrPhotos.self, from: data)
        return flickrPhotos
    }
}
