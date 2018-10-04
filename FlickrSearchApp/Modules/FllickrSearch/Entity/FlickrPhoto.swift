//
//  FlickrPhoto.swift
//  FlickrSearchApp
//
//  Created by Suhit Patil on 03/10/18.
//  Copyright © 2018 Suhit Patil. All rights reserved.
//

import Foundation

struct FlickrPhoto: Decodable {
    let farm: Int
    let id: String
    let owner: String
    let secret: String
    let server: String
    let title: String
}
