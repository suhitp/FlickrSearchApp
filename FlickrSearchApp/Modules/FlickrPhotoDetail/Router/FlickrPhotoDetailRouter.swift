//
//  FlickrPhotoDetailRouter.swift
//  FlickrSearchApp
//
//  Created by Suhit Patil on 12/04/19.
//  Copyright © 2019 Suhit Patil. All rights reserved.
//

import UIKit

final class FlickrPhotoDetailRouter: FlickrPhotoDetailRouterInput {
    
    weak var viewController: UIViewController?
    
    func dismiss() {
        viewController?.dismiss(animated: true)
    }
}
