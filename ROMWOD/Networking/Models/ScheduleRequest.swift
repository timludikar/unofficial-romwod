//
//  Request.swift
//  ROMWOD
//
//  Created by Tim Ludikar on 2018-07-25.
//  Copyright © 2018 Tim Ludikar. All rights reserved.
//

import Foundation

struct ScheduleRequest: Request {
    var userDate: String?
    var archived: Bool?
    var url: URLRequest {
        get {
            var url = URLComponents(string: ROMWOD.WEEKLY)!
            var queryItems = [URLQueryItem]()
            
            if archived != nil  {
                queryItems = [URLQueryItem(name: "archived", value: archived?.description)]
            }
        
            if userDate != nil  {
                queryItems.isEmpty ? queryItems = [URLQueryItem(name: "user_date", value: userDate)] : queryItems.append(URLQueryItem(name: "user_date", value: userDate))
            }
            
            !queryItems.isEmpty ? url.queryItems = queryItems : ()
            
            return URLRequest(url: url.url!)
        }
    }
}
