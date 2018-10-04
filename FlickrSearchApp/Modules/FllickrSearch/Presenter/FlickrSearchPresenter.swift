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
    var flickrSearchViewModel: FlickrSearchViewModel?
    
    func searchFlickrPhotos(matching imageName: String) {
        self.interactor.loadFlickrPhotos(matching: imageName, pageNum: pageNum)
    }
    
    func flickrSearchSuccess(_ flickrPhotos: FlickrPhotos) {
        let flickrPhotoUrlList = buildFlickrPhotoUrlList(from: flickrPhotos.photo)
        print(flickrPhotoUrlList)
//        if totalCount == Constants.defaultTotalCount {
//            flickrSearchViewModel = FlickrSearchViewModel(photoUrlList: flickrPhotoUrlList)
//            totalCount = flickrPhotos.photos.count
//        } else {
//            flickrSearchViewModel?.flickrPhotoUrlList += flickrPhotoUrlList
//            totalCount += flickrPhotos.photos.count
//        }
    }
    
    func flickrSearchError(_ error: NetworkError) {
        print(error.description)
        print(error.localizedDescription)
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
