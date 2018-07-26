//
//  Request.swift
//  ROMWOD
//
//  Created by Tim Ludikar on 2018-07-25.
//  Copyright © 2018 Tim Ludikar. All rights reserved.
//

import Foundation


//app.romwod.com/api/v1/weekly_schedules?archived=false&user_date=\(Date().userDate())"

struct ScheduleRequest {
    var userDate: String?
    var archived: Bool?
    var url: URLComponents {
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
            
            return url
        }
    }
    
    init() {}
    
    init(dateOf userDate: String?) {
        self.userDate = userDate
    }
    
    init(is archived: Bool?) {
        self.archived = archived
    }
    
    init(dateOf userDate: String?, is archived: Bool?){
        self.userDate = userDate
        self.archived = archived
    }
}
