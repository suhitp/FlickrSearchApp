//
//  FlickrImageCell.swift
//  FlickrSearchApp
//
//  Created by Suhit Patil on 02/10/18.
//  Copyright © 2018 Suhit Patil. All rights reserved.
//

import UIKit

final class FlickrImageCell: UICollectionViewCell {
    
    lazy var photoImageView: UIImageView = {
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
        contentView.addSubview(photoImageView)
        photoImageView.edges(to: contentView)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = UIImage(color: .black)
    }
    
    func configure(imageURL: URL, size: CGSize, indexPath: IndexPath) {
        photoImageView.loadImage(fromURL: imageURL, size: size, indexPath: indexPath)
    }
}
