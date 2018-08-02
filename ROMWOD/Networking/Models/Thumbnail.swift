//
//  Thumbnail.swift
//  ROMWOD
//
//  Created by Tim Ludikar on 2018-08-01.
//  Copyright © 2018 Tim Ludikar. All rights reserved.
//

import Foundation

struct Thumbnail: Decodable {
    var height: String
    var scalingParameter: String
    var url: String
    var width: String
    
    enum CodingKeys: String, CodingKey {
        case height
        case width
        case url
        case scalingParameter = "scaling_parameter"
    }
}
