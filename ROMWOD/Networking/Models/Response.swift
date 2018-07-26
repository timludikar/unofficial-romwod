//
//  Response.swift
//  ROMWOD
//
//  Created by Tim Ludikar on 2018-07-26.
//  Copyright © 2018 Tim Ludikar. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
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
    
    func getAll(from url: URLRequest, completion: @escaping((Result<ResponseData>)->Void)) {
        fetch(with: url, completion: completion)
    }
}

struct ResponseData: Decodable {
    var response: [ScheduleResponse]
    
    enum CodingKeys: String, CodingKey {
        case response = "data"
    }
    
}
