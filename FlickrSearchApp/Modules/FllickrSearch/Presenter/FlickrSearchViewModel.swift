//
//  FlickrSearchViewModel.swift
//  FlickrSearchApp
//
//  Created by Suhit Patil on 03/10/18.
//  Copyright © 2018 Suhit Patil. All rights reserved.
//

import Foundation

struct FlickrSearchViewModel {
    
    var photoUrlList: [URL] = []
    
    init(photoUrlList: [URL]) {
        self.photoUrlList = photoUrlList
    }
    
    
    var isEmpty: Bool {
        return photoUrlList.isEmpty
    }
    
    var photoCount: Int {
        return photoUrlList.count
    }
    
    mutating func addMorePhotoUrls(_ photoUrls: [URL]) {
        self.photoUrlList += photoUrls
    }
}

extension FlickrSearchViewModel {
    
    func imageUrlAt(_ index: Int) -> URL {
        guard !photoUrlList.isEmpty else {
            fatalError("No imageUrls available")
        }
        return photoUrlList[index]
    }
    
}
