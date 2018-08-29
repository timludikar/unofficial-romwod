//
//  VideoMetaDataResponse.swift
//  ROMWOD
//
//  Created by Tim Ludikar on 2018-08-29.
//  Copyright © 2018 Tim Ludikar. All rights reserved.
//

import Foundation

struct VideoMetaData: Codable {
    let media: Media
}

struct Media: Codable {
    let assets: [Asset]
}

struct Asset: Codable {
    let type: String
    let slug: String
    let displayName: String
    let width: Int
    let height: Int
    let extType: String
    let size: Int
    let bitrate: Int
    let url: URL
    
    enum CodingKeys: String, CodingKey {
        case type, slug, width, height, size, bitrate, url
        case displayName = "display_name"
        case extType = "ext"
    }
}
