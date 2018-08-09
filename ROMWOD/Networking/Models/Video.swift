//
//  Video.swift
//  ROMWOD
//
//  Created by Tim Ludikar on 2018-08-01.
//  Copyright © 2018 Tim Ludikar. All rights reserved.
//

import Foundation

struct Video: Decodable {
    let id: Int
    let externalId: String
    let title: String
    let description: String
    let slug: String
    let state: String
//    let shortThumbnail: Thumbnail
    let thumbnail: Thumbnail
//    let duration: String
    let createdAt: Date
    let updatedAt: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case externalId = "external_id"
        case title
        case description
        case slug
        case state
        //        case shortThumbnail = "short_thumbnail"
        case thumbnail
        //        case duration = "duration_in_seconds"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}


