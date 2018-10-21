//
//  UIImageView+Extensions.swift
//  FlickrSearchApp
//
//  Created by Suhit Patil on 21/10/18.
//  Copyright © 2018 Suhit Patil. All rights reserved.
//

import UIKit


extension UIImageView {
    
    /*!
     * @description: Load Image into imageView from the given imageUrl using ImageDownloader
     * class
     * @parameters: takes imageURL, placeholderImage and indexPath as params
     */
    func loadImage(fromURL imageURL: URL, placeholder: UIImage? = UIImage(color: .black), size: CGSize, indexPath: IndexPath) {
        self.image = placeholder
        ImageDownloader.shared.downloadImage(withURL: imageURL, size: size, indexPath: indexPath, completion: { [weak self] (image, resultIndexPath, url, error) in
            if let self = self, indexPath.row == resultIndexPath.row, imageURL == url {
                DispatchQueue.main.async {
                    if let downloadedImage = image {
                        UIView.transition(with: self, duration: 0.5, options: .transitionCrossDissolve, animations: {
                            self.image = downloadedImage
                        }, completion: nil)
                    } else {
                        self.image = UIImage(color: .black)
                    }
                }
            }
        })
    }
}
