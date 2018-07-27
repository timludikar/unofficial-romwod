//
//  Request.swift
//  ROMWOD
//
//  Created by Tim Ludikar on 2018-07-25.
//  Copyright © 2018 Tim Ludikar. All rights reserved.
//

import Foundation

struct ScheduleRequest: Router {
    
    let session: URLSession
    
    init(){
        self.init(configuration: URLSessionConfiguration.default)
    }
    
    init(configuration: URLSessionConfiguration){
        self.session = URLSession(configuration: configuration)
    }
    
    init(dateOf userDate: String?) {
        self.init(configuration: URLSessionConfiguration.default)
        self.userDate = userDate
    }
    
    init(is archived: Bool?) {
        self.init(configuration: URLSessionConfiguration.default)
        self.archived = archived
    }
    
    init(dateOf userDate: String?, is archived: Bool?){
        self.init(configuration: URLSessionConfiguration.default)
        self.userDate = userDate
        self.archived = archived
    }
    
    func getAll(completion: @escaping((Result<ResponseData, RequestError>)->Void)) {
        fetch(with: self.url, completion: completion)
    }
    
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
