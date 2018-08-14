//
//  Response.swift
//  ROMWOD
//
//  Created by Tim Ludikar on 2018-07-26.
//  Copyright © 2018 Tim Ludikar. All rights reserved.
//

import Foundation

enum Result<T, U> where U: Error {
    case success(T)
    case failure(U)
}

enum ResponseType {
    case valid
    case invalid(error: RequestError)
}

struct ResponseData: Decodable {
    var response: [ScheduleResponse]
    
    enum CodingKeys: String, CodingKey {
        case response = "data"
    }
}
