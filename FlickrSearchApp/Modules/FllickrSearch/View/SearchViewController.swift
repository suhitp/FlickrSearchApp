//
//  SearchViewController.swift
//  FlickrSearchApp
//
//  Created by Suhit Patil on 05/10/18.
//  Copyright © 2018 Suhit Patil. All rights reserved.
//

import UIKit

protocol FlickrSearchEventDelegate: AnyObject {
    func didTapSearchBar(withText searchText: String)
}

final class SearchViewController: UIViewController, UISearchBarDelegate {

    weak var searchDelegate: FlickrSearchEventDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
       searchBar.resignFirstResponder()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {
            return
        }
        searchBar.text = text
        searchBar.resignFirstResponder()
        searchDelegate?.didTapSearchBar(withText: text)
    }
}
