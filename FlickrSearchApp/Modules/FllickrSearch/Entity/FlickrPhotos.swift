//
//  FlickrPhotos.swift
//  FlickrSearchApp
//
//  Created by Suhit Patil on 03/10/18.
//  Copyright © 2018 Suhit Patil. All rights reserved.
//

import Foundation

struct FlickrPhotos: Decodable {
    let page: Int
    let pages: Int
    let perpage: Int
    let total: String
    let photo: [FlickrPhoto]
    
    enum CodingKeys: String, CodingKey {
        case photos
    }
    
    // The keys inside of the "FlickrPhotosKeys" object
    enum FlickrPhotosKeys: String, CodingKey {
        case page
        case pages
        case perpage
        case total
        case photo
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        // Extract the photos object as a nested container
        let photos = try values.nestedContainer(keyedBy: FlickrPhotosKeys.self, forKey: .photos)

        self.page = try photos.decode(Int.self, forKey: .page)
        self.pages = try photos.decode(Int.self, forKey: .pages)
        self.perpage = try photos.decode(Int.self, forKey: .perpage)
        self.total = try photos.decode(String.self, forKey: .total)
        self.photo = try photos.decode([FlickrPhoto].self, forKey: .photo)
    }
}
