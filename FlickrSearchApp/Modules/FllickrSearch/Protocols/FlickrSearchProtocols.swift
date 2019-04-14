//
//  FlickrSearchProtocols.swift
//  FlickrSearchApp
//
//  Created by Suhit Patil on 28/09/18.
//  Copyright © 2018 Suhit Patil. All rights reserved.
//

import Foundation
import UIKit

//MARK: BaseViewInput

protocol BaseViewInput: AnyObject {
    func showSpinner()
    func hideSpinner()
}

extension BaseViewInput where Self: UIViewController {
    func showSpinner() {
        view.showSpinner()
    }
    
    func hideSpinner() {
        view.hideSpinner()
    }
}


//MARK: View
protocol FlickrSearchViewInput: BaseViewInput {
    var presenter: FlickrSearchViewOutput! { get set }
    func changeViewState(_ state: ViewState)
    func displayFlickrSearchImages(with viewModel: FlickrSearchViewModel)
    func insertFlickrSearchImages(with viewModel: FlickrSearchViewModel, at indexPaths: [IndexPath])
    func resetViews()
}

//MARK: Presenter
protocol FlickrSearchModuleInput: AnyObject {
    var view: FlickrSearchViewInput? { get set }
    var interactor: FlickrSearchInteractorInput! { get set }
    var router: FlickrSearchRouterInput! { get set }
}

protocol FlickrSearchViewOutput: AnyObject {
    func searchFlickrPhotos(matching imageName: String)
    var isMoreDataAvailable: Bool { get }
    func clearData()
    func didSelectPhoto(at index: Int)
}

protocol FlickrSearchInteractorOutput: AnyObject  {
    func flickrSearchSuccess(_ flickrPhotos: FlickrPhotos)
    func flickrSearchError(_ error: NetworkError)
}


//MARK: InteractorInput
protocol FlickrSearchInteractorInput: AnyObject {
    var presenter: FlickrSearchInteractorOutput? { get set }
    func loadFlickrPhotos(matching imageName: String, pageNum: Int)
}

//MARK: Router
protocol FlickrSearchRouterInput: AnyObject {
    func showFlickrPhotoDetails(with imageUrl: URL)
}

