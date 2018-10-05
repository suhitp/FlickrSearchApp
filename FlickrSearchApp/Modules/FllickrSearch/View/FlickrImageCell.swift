//
//  FlickrImageCell.swift
//  FlickrSearchApp
//
//  Created by Suhit Patil on 02/10/18.
//  Copyright © 2018 Suhit Patil. All rights reserved.
//

import UIKit

final class FlickrImageCell: UICollectionViewCell {
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init?(coder:) not implemented")
    }
    

    private func setupViews() {
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.backgroundColor = .black
        contentView.addSubview(imageView)
        imageView.edges(to: contentView)
    }
    
    override func prepareForReuse() {
        imageView.image = nil
        super.prepareForReuse()
    }
    
    func configure(imageURL: URL, size: CGSize, indexPath: IndexPath) {
        imageView.image = UIImage(color: .black)
        ImageDownloader.shared.downloadImage(withURL: imageURL, size: size, indexPath: indexPath, completion: { (image, resultIndexPath) in
            if indexPath.row == resultIndexPath.row {
                DispatchQueue.main.async {
                    if let downloadedImage = image {
                        self.imageView.image = downloadedImage
                    } else {
                        self.imageView.image = UIImage(color: .black)
                    }
                }
            }
        })
    }
}
