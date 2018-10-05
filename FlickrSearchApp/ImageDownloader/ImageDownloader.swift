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
    
    func downloadImage(withURL imageURL: URL, size: CGSize, scale: CGFloat = UIScreen.main.scale, completion: @escaping (UIImage?) -> Void) {
        
        if let cachedImage = imageCache.object(forKey: imageURL.absoluteString as NSString) {
            completion(cachedImage)
            return
        } else {
            let imageOperation = ImageOperation(imageURL: imageURL, size: size, scale: scale)
            if let operation = downloadQueue.operations.first(where: { (operation: Operation) -> Bool in
                    return (operation == imageOperation) && operation.isExecuting
                }) as? ImageOperation {
                 operation.queuePriority = .veryHigh
            } else {
                imageOperation.imageDownloadCompletionHandler = { result in
                    switch result {
                    case let .success(image):
                        self.imageCache.setObject(image, forKey: imageURL.absoluteString as NSString)
                        completion(image)
                    case let .failure(error):
                        print(error.description)
                        completion(nil)
                    }
                }
                imageOperation.queuePriority = .high
                downloadQueue.addOperation(imageOperation)
            }
        }
    }
}
