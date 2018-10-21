//
//  FlickrSearchPresenterTests.swift
//  FlickrSearchAppTests
//
//  Created by Suhit Patil on 21/10/18.
//  Copyright © 2018 Suhit Patil. All rights reserved.
//

import XCTest
@testable import FlickrSearchApp

class FlickrSearchPresenterTests: XCTestCase {

    var interactor: FlickrSearchInteractorMock!
    var presenter: FlickrSearchPresenterMock!
    var view: FlickrSearchViewControllerMock!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        presenter = FlickrSearchPresenterMock()
        interactor = FlickrSearchInteractorMock(presenter: presenter, network: NetworkClientMock())
        view = FlickrSearchViewControllerMock(presenter: presenter)
        
        presenter.interactor = interactor
        presenter.view = view
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        presenter = nil
        view = nil
        interactor = nil
    }
    
    func testSearchMethodCall() {
        presenter.searchFlickrPhotos(matching: "nature")
        XCTAssertTrue(presenter.flickrSearchSuccess)
        XCTAssertTrue(view.showFlickrImages)
        XCTAssertNotNil(presenter.flickrSearchViewModel)
        XCTAssertTrue(presenter.flickrSearchViewModel.photoCount == 2)
    }

}

class FlickrSearchPresenterMock: FlickrSearchModuleInput, FlickrSearchPresentation, FlickrSearchPresenterInput {
   
    weak var view: FlickrSearchViewInput?
    var interactor: FlickrSearchInteractorInput!
    var flickrSearchViewModel: FlickrSearchViewModel!
    
    var isMoreDataAvailable: Bool { return true }
    var flickrSearchSuccess = false
    
    func searchFlickrPhotos(matching imageName: String) {
        interactor.loadFlickrPhotos(matching: imageName, pageNum: 1)
    }
    
    func flickrSearchSuccess(_ flickrPhotos: FlickrPhotos) {
        flickrSearchSuccess = true
        XCTAssertFalse(flickrPhotos.photo.isEmpty)
        let flickrPhotoList = buildFlickrPhotoUrlList(from: flickrPhotos.photo)
        let viewModel = FlickrSearchViewModel(photoUrlList: flickrPhotoList)
        self.flickrSearchViewModel = viewModel
        view?.displayFlickrSearchImages(with: viewModel)
    }
    
    func flickrSearchError(_ error: NetworkError) {
        flickrSearchSuccess = false
    }
    
    func clearData() {
        view?.resetViews()
    }
    
    //MARK: FlickrImageURLList
    func buildFlickrPhotoUrlList(from photos: [FlickrPhoto]) -> [URL] {
        let flickrPhotoUrlList = photos.compactMap { (photo) -> URL? in
            let url = "https://farm\(photo.farm).static.flickr.com/\(photo.server)/\(photo.id)_\(photo.secret).jpg"
            guard let imageUrl = URL(string: url) else {
                return nil
            }
            return imageUrl
        }
        return flickrPhotoUrlList
    }
}


class FlickrSearchViewControllerMock: FlickrSearchViewInput {
    var presenter: FlickrSearchPresentation!
    var showFlickrImages = false
    
    init(presenter: FlickrSearchPresentation) {
        self.presenter = presenter
    }
    
    func changeViewState(_ state: ViewState) {}
    
    func displayFlickrSearchImages(with viewModel: FlickrSearchViewModel) {
        XCTAssertFalse(viewModel.isEmpty)
        XCTAssertTrue(viewModel.photoUrlList.count == 2)
        showFlickrImages = true
    }
    
    func insertFlickrSearchImages(with viewModel: FlickrSearchViewModel, at indexPaths: [IndexPath]) {}
    
    func resetViews() {}
}
