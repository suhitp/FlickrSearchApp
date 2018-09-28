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
}

protocol FlickrSearchModuleInput: AnyObject {
    var view: FlickrSearchViewInput? { get set }
    var interactor: FlickrSearchInteractorInput! { get set }
}

protocol FlickrSearchPresenterInput: AnyObject  {
    
}

protocol FlickrSearchPresentation: AnyObject {
    
}

protocol FlickrSearchInteractorInput: AnyObject {
    var presenter: FlickrSearchPresenterInput! { get set }
}
