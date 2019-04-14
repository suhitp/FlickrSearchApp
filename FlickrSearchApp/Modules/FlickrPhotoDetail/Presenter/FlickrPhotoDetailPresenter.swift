//
//  FlickrPhotoDetailPresenter.swift
//  FlickrSearchApp
//
//  Created by Suhit Patil on 12/04/19.
//  Copyright © 2019 Suhit Patil. All rights reserved.
//

import Foundation

class FlickrPhotoDetailPresenter: FlickrPhotoDetailModuleInput, FlickrPhotoDetailViewOutput {
    
    var view: FlickrPhotoDetailViewInput?
    var router: FlickrPhotoDetailRouterInput!
    
    var imageUrl: URL
    
    init(imageUrl: URL) {
        self.imageUrl = imageUrl
    }
    
    func onViewDidLoad() {
        self.view?.showSpinner()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) { [weak self] in
            guard let self = self else {
                return
            }
            self.view?.renderView(with: self.imageUrl)
            self.view?.hideSpinner()
        }
    }
    
    func didTapClose() {
        router.dismiss()
    }
}
