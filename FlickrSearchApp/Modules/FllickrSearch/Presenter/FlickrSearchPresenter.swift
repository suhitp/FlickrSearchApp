//
//  FlickrSearchPresenter.swift
//  FlickrSearchApp
//
//  Created by Suhit Patil on 28/09/18.
//  Copyright © 2018 Suhit Patil. All rights reserved.
//

import Foundation


final class FlickrSearchPresenter: FlickrSearchModuleInput, FlickrSearchPresenterInput, FlickrSearchPresentation {
    
    weak var view: FlickrSearchViewInput?
    var interactor: FlickrSearchInteractorInput!
    
    var pageNum = Constants.defaultPageNum
    var totalCount: Int = Constants.defaultTotalCount
    var totalPages: Int = Constants.defaultPageNum
    var flickrSearchViewModel: FlickrSearchViewModel!
    
    var isMoreDataAvailable: Bool {
        guard totalPages != 0 else {
            return true
        }
        return pageNum < totalPages
    }
    
    func searchFlickrPhotos(matching imageName: String) {
        guard isMoreDataAvailable else { return }
        view?.changeViewState(.loading)
        pageNum += 1
        interactor.loadFlickrPhotos(matching: imageName, pageNum: pageNum)
    }
    
    func flickrSearchSuccess(_ flickrPhotos: FlickrPhotos) {
        let flickrPhotoUrlList = buildFlickrPhotoUrlList(from: flickrPhotos.photo)
        if totalCount == Constants.defaultTotalCount {
            flickrSearchViewModel = FlickrSearchViewModel(photoUrlList: flickrPhotoUrlList)
            totalCount = flickrPhotos.photo.count
            totalPages = flickrPhotos.pages
            view?.displayFlickrSearchImages(with: flickrSearchViewModel)
        } else {
            let previousCount = totalCount
            totalCount += flickrPhotos.photo.count
            let indexPaths: [IndexPath] = (previousCount..<totalCount).map(IndexPath.init)
            flickrSearchViewModel.photoUrlList += flickrPhotoUrlList
            view?.insertFlickrSearchImages(with: flickrSearchViewModel, at: indexPaths)
        }
        view?.changeViewState(.content)
    }
    
    func flickrSearchError(_ error: NetworkError) {
        view?.changeViewState(.error(error.description))
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
    
    func clearData() {
        pageNum = Constants.defaultPageNum
        totalCount = Constants.defaultTotalCount
        totalPages = Constants.defaultTotalCount
        flickrSearchViewModel = nil
        view?.resetViews()
        view?.changeViewState(.none)
    }
}
