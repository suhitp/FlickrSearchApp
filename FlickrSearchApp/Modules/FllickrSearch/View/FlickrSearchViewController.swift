//
//  FlickrSearchViewController.swift
//  FlickrSearchApp
//
//  Created by Suhit Patil on 28/09/18.
//  Copyright © 2018 Suhit Patil. All rights reserved.
//

import UIKit

//MARK: ViewState
public enum ViewState: Equatable {
    case none
    case loading
    case error(String)
    case content
}

final class FlickrSearchViewController: UIViewController, FlickrSearchViewInput {
    
    var presenter: FlickrSearchPresentation!
    var viewState: ViewState = .none
    var searchText = ""
    var flickrSearchViewModel: FlickrSearchViewModel?

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
        collectionView.backgroundColor = .white
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
        presenter.searchFlickrPhotos(matching: "nature")
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
    
    func changeViewState(_ state: ViewState) {
        DispatchQueue.main.async { [unowned self] in
            self.viewState = state
            switch state {
            case .loading:
                self.view.showSpinner()
            case .content:
                self.view.hideSpinner()
            case .error(let message):
                self.view.hideSpinner()
                self.showAlert(title: Strings.error, message: message, retryAction: { [unowned self] in
                    self.presenter.searchFlickrPhotos(matching: self.searchText)
                    }
                )
            default:
                break
            }
        }
    }
    
    func displayFlickrSearchImages(with viewModel: FlickrSearchViewModel) {
        DispatchQueue.main.async {
            self.flickrSearchViewModel = viewModel
            self.collectionView.reloadData()
        }
    }
    
    func updateFlickrSearchImages(with viewModel: FlickrSearchViewModel) {
        DispatchQueue.main.async {
            self.flickrSearchViewModel = viewModel
            self.collectionView.reloadData()
        }
    }
}


//MARK: UICollectionViewDataSource & UICollectionViewDelegate
extension FlickrSearchViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = self.flickrSearchViewModel else {
            return 0
        }
        return viewModel.photoUrlList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Strings.reuseIdentifier, for: indexPath) as! FlickrImageCell
        guard let viewModel = flickrSearchViewModel else { return cell }
        let imageURL = viewModel.photoUrlList[indexPath.row]
        cell.configure(imageURL: imageURL, size: collectionViewLayout.itemSize)
        return cell
    }
}

