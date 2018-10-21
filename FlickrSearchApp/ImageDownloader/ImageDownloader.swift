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
    
    typealias imageDownloadCompletion = ((UIImage?, IndexPath, URL, Error?) -> Void)
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
    
    func downloadImage(withURL imageURL: URL, size: CGSize, scale: CGFloat = UIScreen.main.scale, indexPath: IndexPath, completion: @escaping imageDownloadCompletion) {
        
        if let cachedImage = imageCache.object(forKey: imageURL.absoluteString as NSString) {
            completion(cachedImage, indexPath, imageURL, nil)
            return
        } else {
            if let existingImageOperations = downloadQueue.operations as? [ImageOperation],
                let imgOperation = existingImageOperations.first(where: {
                    return ($0.imageURL == imageURL) && $0.isExecuting && !$0.isFinished
                }) {
                imgOperation.queuePriority = .veryHigh
            } else {
                let imageOperation = ImageOperation(imageURL: imageURL, size: size, scale: scale)
                imageOperation.queuePriority = .high
                downloadQueue.addOperation(imageOperation)
                imageOperation.imageDownloadCompletionHandler = { result in
                    switch result {
                    case let .success(image):
                        self.imageCache.setObject(image, forKey: imageURL.absoluteString as NSString)
                        completion(image, indexPath, imageURL, nil)
                    case let .failure(error):
                        completion(nil, indexPath, imageURL, error)
                    }
                }
            }
        }
    }
    
    func cancelAll() {
        downloadQueue.cancelAllOperations()
    }
    
    func cancelOperation(imageUrl: URL) {
        if let imageOperations = downloadQueue.operations as? [ImageOperation],
            let operation = imageOperations.first(where: { $0.imageURL == imageUrl }) {
            operation.cancel()
        }
    }
}
