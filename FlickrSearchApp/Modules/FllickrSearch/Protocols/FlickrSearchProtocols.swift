//
//  FlickrSearchProtocols.swift
//  FlickrSearchApp
//
//  Created by Suhit Patil on 28/09/18.
//  Copyright © 2018 Suhit Patil. All rights reserved.
//

import Foundation


protocol FlickrSearchViewInput: AnyObject {
    var presenter: FlickrSearchPresentation! { get set }
    func changeViewState(_ state: ViewState)
    func displayFlickrSearchImages(with viewModel: FlickrSearchViewModel)
    func insertFlickrSearchImages(with viewModel: FlickrSearchViewModel, at indexPaths: [IndexPath])
    func resetViews()
}

protocol FlickrSearchModuleInput: AnyObject {
    var view: FlickrSearchViewInput? { get set }
    var interactor: FlickrSearchInteractorInput! { get set }
}

protocol FlickrSearchPresenterInput: AnyObject  {
    func flickrSearchSuccess(_ flickrPhotos: FlickrPhotos)
    func flickrSearchError(_ error: NetworkError)
}

protocol FlickrSearchPresentation: AnyObject {
    func searchFlickrPhotos(matching imageName: String)
    var isMoreDataAvailable: Bool { get }
    func clearData()
}

protocol FlickrSearchInteractorInput: AnyObject {
    var presenter: FlickrSearchPresenterInput? { get set }
    func loadFlickrPhotos(matching imageName: String, pageNum: Int)
}
