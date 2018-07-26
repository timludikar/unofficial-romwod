//
//  Response.swift
//  ROMWOD
//
//  Created by Tim Ludikar on 2018-07-26.
//  Copyright © 2018 Tim Ludikar. All rights reserved.
//

import Foundation

enum Result {
    case success(Data)
    case failure
}

enum Response {
    case workoutSchedule
}

class Workouts: Router {
    
    let session: URLSession
    
    init(configuration: URLSessionConfiguration){
        self.session = URLSession(configuration: configuration)
    }    
}

struct ResponseData<Element: Decodable>: Decodable {
    var response: [Element]
    
    enum CodingKeys: String, CodingKey {
        case response = "data"
    }
    
}
