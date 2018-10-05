//
//  ImageDownloader.swift
//  FlickrSearchApp
//
//  Created by Suhit Patil on 04/10/18.
//  Copyright © 2018 Suhit Patil. All rights reserved.
//

import Foundation
import UIKit

final class ImageDownloader {
    
    private let imageCache = NSCache<NSString, UIImage>()
    
    lazy var downloadQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "com.image.downloadQueue"
        queue.maxConcurrentOperationCount = 4
        queue.qualityOfService = .userInitiated
        return queue
    }()
    
    static let shared = ImageDownloader()
    private init() {}
    
    func downloadImage(withURL imageURL: URL, size: CGSize, scale: CGFloat = UIScreen.main.scale, indexPath: IndexPath, completion: @escaping (UIImage?, IndexPath) -> Void) {
        
        if let cachedImage = imageCache.object(forKey: imageURL.absoluteString as NSString) {
            completion(cachedImage, indexPath)
            return
        } else {
            if let existingImageOperations = (downloadQueue.operations as? [ImageOperation])?.first(where: { (operation: ImageOperation) in
                return (operation.imageURL == imageURL) && operation.isExecuting
            }) {
                existingImageOperations.queuePriority = .veryHigh
            } else {
                let imageOperation = ImageOperation(imageURL: imageURL, size: size, scale: scale)
                imageOperation.imageDownloadCompletionHandler = { result in
                    switch result {
                    case let .success(image):
                        self.imageCache.setObject(image, forKey: imageURL.absoluteString as NSString)
                        completion(image, indexPath)
                    case let .failure(error):
                        print(error.description)
                        completion(nil, indexPath)
                    }
                }
                imageOperation.queuePriority = .high
                downloadQueue.addOperation(imageOperation)
            }
        }
    }
    
    func cancelAll() {
        downloadQueue.cancelAllOperations()
    }
}
