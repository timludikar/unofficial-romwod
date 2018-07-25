//
//  Request.swift
//  ROMWOD
//
//  Created by Tim Ludikar on 2018-07-24.
//  Copyright © 2018 Tim Ludikar. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
}

protocol Request {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String:String]? { get }
    var headers: [String:String]? { get }
    var getURL: URL? { get }

}

struct RequestData: Request {
    var baseURL: String
    var path: String
    var method: HTTPMethod
    var parameters: [String : String]?
    var headers: [String : String]?
    
    init(_ baseURL: String, path: String) {
        self.baseURL = baseURL
        self.path = path
        self.method = .get
        
    }
    
    var getURL: URL? {
        get {
            return URL(string: baseURL+path)
        }
    }
}
