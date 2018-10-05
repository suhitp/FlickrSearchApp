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
}
