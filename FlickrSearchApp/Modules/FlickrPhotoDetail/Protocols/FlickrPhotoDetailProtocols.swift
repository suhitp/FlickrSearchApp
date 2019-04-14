//
//  FlickrPhotoDetailProtocols.swift
//  FlickrSearchApp
//
//  Created by Suhit Patil on 12/04/19.
//  Copyright © 2019 Suhit Patil. All rights reserved.
//

import UIKit


protocol FlickrPhotoDetailViewInput: BaseViewInput {
    func renderView(with imageUrl: URL)
}

protocol FlickrPhotoDetailViewOutput: AnyObject {
   func didTapClose()
   func onViewDidLoad()
}

protocol FlickrPhotoDetailModuleInput: AnyObject {
    var view: FlickrPhotoDetailViewInput? { get set }
    var router: FlickrPhotoDetailRouterInput! { get set }
}

protocol FlickrPhotoDetailInteractorInput: AnyObject {
    
}

protocol FlickrPhotoDetailInteractorOutput: AnyObject {
    
}

protocol FlickrPhotoDetailRouterInput: AnyObject {
    func dismiss()
}
