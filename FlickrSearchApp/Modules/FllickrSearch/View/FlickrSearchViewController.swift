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

    lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        let numberOfColumns: CGFloat = 3
        let spacing: CGFloat = 1
        let itemSize: CGFloat = (UIScreen.main.bounds.width - (numberOfColumns - spacing) - 2) / numberOfColumns
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .lightGray
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    lazy var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        if #available(iOS 11, *) {
            controller.obscuresBackgroundDuringPresentation = false
        } else {
            controller.dimsBackgroundDuringPresentation = false
        }
        controller.searchResultsUpdater = nil
        controller.searchBar.placeholder = "Search for your favourite images"
        controller.searchBar.enablesReturnKeyAutomatically = false
        controller.searchBar.tintColor = .black
        controller.searchBar.barStyle = .default
        definesPresentationContext = true
        controller.searchBar.delegate = nil
        return controller
    }()

    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        navigationItem.title = "Flickr Search"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    private func setupViews() {
        configureCollectionView()
        configureSearchController()
    }

    //MARK: configureSearchController
    private func configureSearchController() {
        if #available(iOS 11, *) {
            navigationItem.searchController = searchController
        } else {
            navigationItem.titleView = searchController.view
        }
        definesPresentationContext = true
    }

    //MARK: ConfigureCollectionView
    private func configureCollectionView() {
        view.addSubview(collectionView)
        collectionView.edgesToSuperView()
        collectionView.register(FlickrImageCell.self, forCellWithReuseIdentifier: FlickrImageCell.reuseIdentifier)
    }
}


//MARK: UICollectionViewDataSource & UICollectionViewDelegate
extension FlickrSearchViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FlickrImageCell.reuseIdentifier, for: indexPath) as! FlickrImageCell
        return cell
    }
}

