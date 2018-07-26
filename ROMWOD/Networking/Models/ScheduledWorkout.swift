//
//  ScheduledWorkout.swift
//  ROMWOD
//
//  Created by Tim Ludikar on 2018-07-26.
//  Copyright © 2018 Tim Ludikar. All rights reserved.
//

import Foundation

struct ScheduledWorkouts: Decodable {
    var id: Int
    var name: String
    var description: String
    var date: String
    var isNew: Bool
    var quote: String
    var videoOrder: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case date
        case isNew = "is_new"
        case quote
        case videoOrder = "video_order"
    }
}
