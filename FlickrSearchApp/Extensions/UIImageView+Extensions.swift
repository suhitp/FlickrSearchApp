//
//  UIImageView+Extensions.swift
//  FlickrSearchApp
//
//  Created by Suhit Patil on 21/10/18.
//  Copyright © 2018 Suhit Patil. All rights reserved.
//

import UIKit

struct AssociatedKeys {
    static var imageUrlKey: UInt64 = 0
}

extension UIImageView {
    
    private(set) var downloadImageURL: URL? {
        get {
            guard let value = objc_getAssociatedObject(self, &AssociatedKeys.imageUrlKey) as? URL else {
                return nil
            }
            return value
        }
        set(newValue) {
            objc_setAssociatedObject(self, &AssociatedKeys.imageUrlKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    
    /// load image from remote url
    /// - Parameters:
    ///   - imageURL: is the `URL` which points to Https url
    ///   - placeholder: `UIImage` placeholder
    ///   - size: image container size
    func loadImage(
        with imageURL: URL,
        placeholder: UIImage? = UIImage(color: .placeholder),
        size: CGSize
    ) {
        image = placeholder
        downloadImageURL = imageURL
        ImageDownloader.shared.downloadImage(
            withURL: imageURL,
            size: size,
            completion: { [weak self] (image, isCached, url, error) in
                guard let self = self, let downloadURL = self.downloadImageURL, imageURL == downloadURL else {
                    return
                }
                DispatchQueue.main.async {
                    if let downloadedImage = image, let isCached = isCached {
                        if isCached {
                            self.image = downloadedImage
                        } else {
                            UIView.transition(with: self, duration: 0.5, options: .transitionCrossDissolve, animations: {
                                self.image = downloadedImage
                            }, completion: nil)
                        }
                    } else {
                        self.image = placeholder
                    }
                }
            }
        )
    }
    
    //MARK: Fade transition Animation
    func fadeTransition(
        with image: UIImage?,
        duration: TimeInterval = 0.5,
        completion: ((Bool) -> Void)? = nil
    ) {
        UIView.transition(
            with: self,
            duration: duration,
            options: .transitionCrossDissolve,
            animations: {
                self.image = image
            },
            completion: completion
        )
    }
}
