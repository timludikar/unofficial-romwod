//
//  HTTPClient.swift
//  ROMWOD
//
//  Created by Tim Ludikar on 2018-07-27.
//  Copyright © 2018 Tim Ludikar. All rights reserved.
//

import Foundation

class HTTPClient: Router {
    let session: URLSession
    
    init(with sessionConfiguration: URLSessionConfiguration){
        self.session = URLSession(configuration: sessionConfiguration)
    }
    
    convenience init(){
        self.init(with: .default)
    }
    
    func getSchedule(from url: URLRequest, completion: @escaping((Result<ResponseData, RequestError>) -> Void)){
        fetch(with: url, completion: completion)
    }
    
    func signIn(from url: URLRequest, with data: LoginRequest, completion: @escaping((Result<ProfileResponse, RequestError>)->Void)){
        upload(with: url, from: data, completion: completion)
    }
    
    func getVideoDetails(from url: URLRequest) {
        let task = URLSession.shared.dataTask(with: url){ (data, response, error) in
            print(data)
        }
        task.resume()
    }
}
