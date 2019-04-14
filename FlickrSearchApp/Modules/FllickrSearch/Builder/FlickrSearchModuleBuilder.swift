//
//  FlickrSearchModuleBuilder.swift
//  FlickrSearchApp
//
//  Created by Suhit Patil on 28/09/18.
//  Copyright © 2018 Suhit Patil. All rights reserved.
//

import UIKit


protocol FlickrModuleBuilder: AnyObject {
    func buildModule() -> FlickrSearchViewController
}


final class FlickrSearchModuleBuilder: FlickrModuleBuilder {
    
    func buildModule() -> FlickrSearchViewController {
        let flickrViewController = FlickrSearchViewController()
        let presenter = FlickrSearchPresenter()
        let network = NetworkAPIClient()
        let interactor = FlickrSearchIneractor(network: network)
        let router = FlickrSearchRouter()
        
        presenter.view = flickrViewController
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        flickrViewController.presenter = presenter
        router.viewController = flickrViewController
        
        return flickrViewController
    }
}
