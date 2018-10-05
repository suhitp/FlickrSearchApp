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
}
