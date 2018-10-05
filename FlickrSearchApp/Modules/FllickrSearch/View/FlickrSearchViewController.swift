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

final class FlickrSearchViewController: UIViewController, FlickrSearchViewInput, FlickrSearchEventDelegate {
    
    var presenter: FlickrSearchPresentation!
    var viewState: ViewState = .none
    var searchText = "nature"
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
        let searchVC = SearchViewController()
        searchVC.searchDelegate = self
        let controller = UISearchController(searchResultsController: searchVC)
        if #available(iOS 11, *) {
            controller.obscuresBackgroundDuringPresentation = true
        } else {
            controller.dimsBackgroundDuringPresentation = true
        }
        controller.searchResultsUpdater = nil
        controller.searchBar.placeholder = Strings.placeholder
        controller.searchBar.delegate = searchVC
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
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationItem.hidesSearchBarWhenScrolling = false
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
        collectionView.register(FooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: FooterView.reuseIdentifer)
    }
    
    func changeViewState(_ state: ViewState) {
        DispatchQueue.main.async { [unowned self] in
            self.viewState = state
            switch state {
            case .loading:
                if self.flickrSearchViewModel == nil {
                    self.view.showSpinner()
                }
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
    
    func insertFlickrSearchImages(with viewModel: FlickrSearchViewModel, at indexPaths: [IndexPath]) {
        DispatchQueue.main.async {
            self.flickrSearchViewModel = viewModel
            self.collectionView.reloadData()
        }
    }
    
    func didTapSearchBar(withText searchText: String) {
        searchController.isActive = false
        guard !searchText.isEmpty || searchText != self.searchText else { return }
        presenter.clearData()
        
        self.searchText = searchText
        ImageDownloader.shared.cancelAll()
        presenter.searchFlickrPhotos(matching: searchText)
    }
    
    func resetViews() {
        searchController.searchBar.text = nil
        flickrSearchViewModel = nil
        collectionView.reloadData()
    }
}


//MARK: UICollectionViewDataSource & UICollectionViewDelegate
extension FlickrSearchViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = self.flickrSearchViewModel, !viewModel.isEmpty else {
            return 0
        }
        return viewModel.photoCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Strings.reuseIdentifier, for: indexPath) as! FlickrImageCell
        guard let viewModel = flickrSearchViewModel else { return cell }
        let imageURL = viewModel.photoUrlList[indexPath.row]
        cell.configure(imageURL: imageURL, size: collectionViewLayout.itemSize, indexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let viewModel = flickrSearchViewModel else { return }
        guard viewState != .loading, indexPath.row == (viewModel.photoCount - 1) else {
            return
        }
        presenter.searchFlickrPhotos(matching: searchText)
    }
    
    //MARK: Footer
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if viewState == .loading && flickrSearchViewModel != nil {
            return CGSize(width: Constants.screenWidth, height: 50)
        }
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String,  at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionFooter:
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FooterView.reuseIdentifer, for: indexPath) as! FooterView
            return footerView
        default:
            assert(false, "Unexpected element kind")
        }
    }
}

