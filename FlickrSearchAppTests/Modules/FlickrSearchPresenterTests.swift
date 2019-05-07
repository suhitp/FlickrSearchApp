//
//  FlickrSearchPresenterTests.swift
//  FlickrSearchAppTests
//
//  Created by Suhit Patil on 21/10/18.
//  Copyright © 2018 Suhit Patil. All rights reserved.
//

import XCTest
@testable import FlickrSearchApp

final class FlickrSearchPresenterTests: XCTestCase {
    
    var interactor: FlickrSearchInteractorMock!
    var presenter: FlickrSearchPresenterMock!
    var view: FlickrSearchViewControllerMock!
    var router: FlickrSearchRouterInput!
    var network: NetworkService!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        presenter = FlickrSearchPresenterMock()
        network = NetworkClientMock()
        interactor = FlickrSearchInteractorMock(presenter: presenter, network: network)
        router = FlickrSearchRouterMock()
        view = FlickrSearchViewControllerMock(presenter: presenter)
        
        presenter.interactor = interactor
        presenter.view = view
        presenter.router = router
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        presenter = nil
        view = nil
        interactor = nil
        network = nil
    }
    
    func testSearchMethodCall() {
        presenter.searchFlickrPhotos(matching: "nature")
        XCTAssertTrue(presenter.flickrSearchSuccess)
        XCTAssertTrue(view.showFlickrImages)
        XCTAssertNotNil(presenter.flickrSearchViewModel)
        XCTAssertTrue(presenter.flickrSearchViewModel.photoCount == 2)
    }
    
    func testDidSelectPhotoCall() {
        presenter.didSelectPhoto(at: 0)
        XCTAssertTrue(presenter.selectedPhoto)
    }
}

final class FlickrSearchPresenterMock: FlickrSearchModuleInput, FlickrSearchViewOutput, FlickrSearchInteractorOutput {
    
    weak var view: FlickrSearchViewInput?
    var interactor: FlickrSearchInteractorInput!
    var router: FlickrSearchRouterInput!
    var flickrSearchViewModel: FlickrSearchViewModel!
    
    var isMoreDataAvailable: Bool { return true }
    var flickrSearchSuccess = false
    var selectedPhoto = false
    
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
            let url = "https://farm\(photo.farm).staticflickr.com.com/\(photo.server)/\(photo.id)_\(photo.secret).jpg"
            guard let imageUrl = URL(string: url) else {
                return nil
            }
            return imageUrl
        }
        return flickrPhotoUrlList
    }
    
    func didSelectPhoto(at index: Int) {
        selectedPhoto = true
    }
}


final class FlickrSearchViewControllerMock: UIViewController, FlickrSearchViewInput {
    
    var presenter: FlickrSearchViewOutput!
    var showFlickrImages = false
    
    init(presenter: FlickrSearchViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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


final class FlickrSearchRouterMock: FlickrSearchRouterInput {
    
    weak var viewController: UIViewController?
    var showFlickrPhotoDetailsCalled = false
    
    func showFlickrPhotoDetails(with imageUrl: URL) {
        showFlickrPhotoDetailsCalled = true
    }
}
