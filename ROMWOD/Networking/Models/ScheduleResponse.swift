//
//  ScheduleResponse.swift
//  ROMWOD
//
//  Created by Tim Ludikar on 2018-07-26.
//  Copyright © 2018 Tim Ludikar. All rights reserved.
//

import Foundation

struct ScheduleResponse: Decodable {
    
    var id: Int
    var title: String
    var startDate: String
    var endDate: String
    var slug: String
    var state: String
    var workouts: [ScheduledWorkouts]
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case startDate = "start_date"
        case endDate = "end_date"
        case slug
        case state
        case workouts = "scheduled_workouts"
    }
}
