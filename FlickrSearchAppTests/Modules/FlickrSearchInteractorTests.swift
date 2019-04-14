//
//  FlickrSearchInteractorTests.swift
//  FlickrSearchAppTests
//
//  Created by Suhit Patil on 21/10/18.
//  Copyright © 2018 Suhit Patil. All rights reserved.
//

import XCTest
@testable import FlickrSearchApp

class FlickrSearchInteractorTests: XCTestCase {
    
    var interactor: FlickrSearchInteractorMock!
    var presenter: FlickrSearchPresenterInputMock!
    
    override func setUp() {
        presenter = FlickrSearchPresenterInputMock()
        let network = NetworkClientMock()
        interactor = FlickrSearchInteractorMock(presenter: presenter, network: network)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        interactor = nil
        presenter = nil
    }
    
    func testLoadFlickrPhotos() {
        interactor.loadFlickrPhotos(matching: "nature", pageNum: 1)
        XCTAssertTrue(presenter.flickrSuccessCalled)
        XCTAssertTrue(interactor.loadPhotosCalled)
    }
    
    func testLoadFlickrPhotosErrorResponse() {
        interactor.loadFlickrPhotos(matching: "nature", pageNum: -1)
        XCTAssertFalse(presenter.flickrSuccessCalled)
        XCTAssertTrue(interactor.loadPhotosCalled)
    }
}


class FlickrSearchInteractorMock: FlickrSearchInteractorInput {
    
    weak var presenter: FlickrSearchInteractorOutput?
    var loadPhotosCalled: Bool = false
    var network: NetworkService?
    
    init(presenter: FlickrSearchInteractorOutput, network: NetworkService) {
        self.presenter = presenter
        self.network = network
    }
    
    func loadFlickrPhotos(matching imageName: String, pageNum: Int) {
        network?.dataRequest(FlickrSearchAPI.search(query: imageName, page: pageNum), objectType: FlickrPhotos.self) { (result) in
            switch result {
            case let .success(flickrPhotos):
                self.loadPhotosCalled = true
                self.presenter?.flickrSearchSuccess(flickrPhotos)
            case let .failure(error):
                self.presenter?.flickrSearchError(error)
                self.loadPhotosCalled = true
            }
        }
    }
}

class FlickrSearchPresenterInputMock: FlickrSearchInteractorOutput {
    
    var flickrSuccessCalled = false
    
    func flickrSearchSuccess(_ flickrPhotos: FlickrPhotos) {
        flickrSuccessCalled = true
        XCTAssertFalse(flickrPhotos.photo.isEmpty)
    }
    
    func flickrSearchError(_ error: NetworkError) {
        flickrSuccessCalled = false
    }
}
