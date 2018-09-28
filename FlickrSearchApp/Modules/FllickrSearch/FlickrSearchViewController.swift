//
//  FlickrSearchViewController.swift
//  FlickrSearchApp
//
//  Created by Suhit Patil on 28/09/18.
//  Copyright © 2018 Suhit Patil. All rights reserved.
//

import UIKit

final class FlickrSearchViewController: UIViewController, FlickrSearchViewInput {
    
    var presenter: FlickrSearchPresentation!

    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
    }
}
