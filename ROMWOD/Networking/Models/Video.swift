//
//  Video.swift
//  ROMWOD
//
//  Created by Tim Ludikar on 2018-08-01.
//  Copyright © 2018 Tim Ludikar. All rights reserved.
//

import Foundation

struct Video: Decodable {
    var id: Int
    var externalId: String
    var title: String
    var description: String
    var slug: String
    var state: String
//    var shortThumbnail: Thumbnail
    var thumbnail: Thumbnail
//    var duration: String
    var createdAt: String
    var updatedAt: String

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


