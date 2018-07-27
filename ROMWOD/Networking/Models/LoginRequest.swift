//
//  LoginRequest.swift
//  ROMWOD
//
//  Created by Tim Ludikar on 2018-07-27.
//  Copyright © 2018 Tim Ludikar. All rights reserved.
//

import Foundation

struct Login: Router {
    let session: URLSession
    var email: String
    var password: String
    var rememberMe: Bool
    
    init(email: String, password: String, rememberMe: Bool){
        self.init(configuration: URLSessionConfiguration.default, email: email, password: password, rememberMe: rememberMe)
    }
    
    init(configuration: URLSessionConfiguration, email: String, password: String, rememberMe: Bool){
        self.session = URLSession(configuration: configuration)
        self.email = email
        self.password = password
        self.rememberMe = rememberMe
    }
    
    func login(with url: URLRequest, completion: @escaping((Result<ResponseData, RequestError>)->Void)){
        upload(with: url, from: self, completion: completion)
    }
    
    enum CodingKeys: String, CodingKey {
        case email = "username"
        case password
        case rememberMe = "remember_me"
    }
}

extension Login: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(email, forKey: .email)
        try container.encode(password, forKey: .password)
        try container.encode(rememberMe, forKey: .rememberMe)
    }
}
