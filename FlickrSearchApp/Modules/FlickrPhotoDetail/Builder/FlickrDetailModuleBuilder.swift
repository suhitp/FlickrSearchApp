//
//  FlickrDetailModuleBuilder.swift
//  FlickrSearchApp
//
//  Created by Suhit Patil on 13/04/19.
//  Copyright © 2019 Suhit Patil. All rights reserved.
//

import Foundation

protocol FlickrDetailModuleBuilder {
    func buildModule(with imageUrl: URL) -> FlickrPhotoDetailViewController
}

class FlickrPhotoDetailModuleBuilder: FlickrDetailModuleBuilder {
    
    func buildModule(with imageUrl: URL) -> FlickrPhotoDetailViewController {
        
        let detailViewController = FlickrPhotoDetailViewController()
        let presenter = FlickrPhotoDetailPresenter(imageUrl: imageUrl)
        let router = FlickrPhotoDetailRouter()
        
        presenter.view = detailViewController
        presenter.router = router
        
        detailViewController.presenter = presenter
        router.viewController = detailViewController
        
        return detailViewController
    }
}
