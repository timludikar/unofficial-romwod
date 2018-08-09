//
//  LoginRequest.swift
//  ROMWOD
//
//  Created by Tim Ludikar on 2018-07-27.
//  Copyright © 2018 Tim Ludikar. All rights reserved.
//

import Foundation

struct LoginRequest: Request {
    init(email: String, password: String, rememberMe: Bool){
        self.email = email
        self.password = password
        self.rememberMe = rememberMe
    }
    
    var url: URLRequest = {
        let url = URL(string: ROMWOD.SIGNIN)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }()
    
    var email: String
    var password: String
    var rememberMe: Bool
    
    enum CodingKeys: String, CodingKey {
        case email = "username"
        case password
        case rememberMe = "remember_me"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(email, forKey: .email)
        try container.encode(password, forKey: .password)
        try container.encode(rememberMe, forKey: .rememberMe)
    }
}
