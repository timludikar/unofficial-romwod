//
//  ScheduledWorkout.swift
//  ROMWOD
//
//  Created by Tim Ludikar on 2018-07-26.
//  Copyright © 2018 Tim Ludikar. All rights reserved.
//

import Foundation

struct ScheduledWorkouts: Decodable {
    let id: Int
    let name: String
    let description: String
    let date: Date
    let isNew: Bool
    let quote: String
    let videoOrder: Int
    let video: Video

    var isHidden = true
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case date
        case isNew = "is_new"
        case quote
        case videoOrder = "video_order"
        case video
    }
}
