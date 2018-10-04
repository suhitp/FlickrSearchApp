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
        let spacing = Constants.defaultSpacing
        let itemSize: CGFloat = (UIScreen.main.bounds.width - (Constants.numberOfColumns - spacing) - 2) / Constants.numberOfColumns
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
        controller.searchBar.placeholder = Strings.placeholder
        controller.searchBar.enablesReturnKeyAutomatically = false
        controller.searchBar.tintColor = .black
        controller.searchBar.barStyle = .default
        controller.searchBar.delegate = nil
        return controller
    }()

    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        navigationItem.title = Strings.searchPageTitle
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
        collectionView.register(FlickrImageCell.self, forCellWithReuseIdentifier: Strings.reuseIdentifier)
    }
}


//MARK: UICollectionViewDataSource & UICollectionViewDelegate
extension FlickrSearchViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Strings.reuseIdentifier, for: indexPath) as! FlickrImageCell
        return cell
    }
}

