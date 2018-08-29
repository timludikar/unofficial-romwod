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
}
