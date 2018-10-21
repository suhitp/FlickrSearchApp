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
    
    var isEmpty: Bool {
        return photoUrlList.isEmpty
    }
    
    var photoCount: Int {
        return photoUrlList.count
    }

    init(photoUrlList: [URL]) {
        self.photoUrlList = photoUrlList
    }
    
    mutating func addMorePhotosUrls(_ photoUrls: [URL]) {
        self.photoUrlList += photoUrls
    }
}

