
//
//  FlickrSearchRouterInout.swift
//  FlickrSearchApp
//
//  Created by Suhit Patil on 13/04/19.
//  Copyright © 2019 Suhit Patil. All rights reserved.
//

import UIKit


final class FlickrSearchRouter: FlickrSearchRouterInput {
   
    weak var viewController: UIViewController?
    
    func showFlickrPhotoDetails(with imageUrl: URL) {
        let detailVC =  FlickrPhotoDetailModuleBuilder().buildModule(with: imageUrl)
        viewController?.present(detailVC, animated: true)
    }
}
