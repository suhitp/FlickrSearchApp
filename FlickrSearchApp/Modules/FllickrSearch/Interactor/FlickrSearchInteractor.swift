//
//  FlickrSearchInteractor.swift
//  FlickrSearchApp
//
//  Created by Suhit Patil on 28/09/18.
//  Copyright © 2018 Suhit Patil. All rights reserved.
//

import Foundation

final class FlickrSearchIneractor: FlickrSearchInteractorInput {
  
    let network: NetworkService
    weak var presenter: FlickrSearchPresenterInput?
    
    init(network: NetworkService) {
        self.network = network
    }
    
    //MARK: Load Flickr images for searched text from the network
    func loadFlickrPhotos(matching imageName: String, pageNum: Int) {
        let endPoint = FlickrSearchAPI.search(query: imageName, page: pageNum)
        network.dataRequest(endPoint, objectType: FlickrPhotos.self) { [weak self] (result: Result<FlickrPhotos>) in
            guard let self = self else { return }
            switch result {
            case let .success(response):
                self.presenter?.flickrSearchSuccess(response)
            case let .failure(error):
                self.presenter?.flickrSearchError(error)
            }
        }
    }
}
