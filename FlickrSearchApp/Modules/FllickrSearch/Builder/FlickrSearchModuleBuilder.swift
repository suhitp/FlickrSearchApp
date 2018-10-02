//
//  FlickrSearchModuleBuilder.swift
//  FlickrSearchApp
//
//  Created by Suhit Patil on 28/09/18.
//  Copyright © 2018 Suhit Patil. All rights reserved.
//

import UIKit


protocol ModuleBuilder: AnyObject {
    func buildModule() -> FlickrSearchViewController
}


final class FlickrSearchModuleBuilder: ModuleBuilder {
    
    func buildModule() -> FlickrSearchViewController {
        let flickrViewController = FlickrSearchViewController()
        let presenter = FlickrSearchPresenter()
        let interactor = FlickrSearchIneractor()
        
        presenter.view = flickrViewController
        presenter.interactor = interactor
        interactor.presenter = presenter
        flickrViewController.presenter = presenter
        
        return flickrViewController
    }
}
