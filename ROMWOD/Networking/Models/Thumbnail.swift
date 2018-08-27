//
//  Thumbnail.swift
//  ROMWOD
//
//  Created by Tim Ludikar on 2018-08-01.
//  Copyright © 2018 Tim Ludikar. All rights reserved.
//

import Foundation
import UIKit

struct Thumbnail: Decodable {
    let height: String
    let width: String
    let scalingParameter: String
    let url: URL
    
    enum CodingKeys: String, CodingKey {
        case height
        case width
        case url
        case scalingParameter = "scaling_parameter"
    }
}
