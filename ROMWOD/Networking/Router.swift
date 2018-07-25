//
//  Router.swift
//  ROMWOD
//
//  Created by Tim Ludikar on 2018-07-24.
//  Copyright © 2018 Tim Ludikar. All rights reserved.
//

import Foundation

protocol RouterDelegate: class {
    func requestDidFinish(_ sender: Router, receivedData data: Data?)
    func requestFailed(_ sender: Router, error: Error)
}

class Router {
    
    weak var delegate: RouterDelegate?
  
    func makeRequest(to url: RequestData){
        let task = URLSession.shared.dataTask(with: url.getURL!){ data, response, error in

            if let error = error {
                self.delegate?.requestFailed(self, error: error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                return
            }
            
            if let mimeType = httpResponse.mimeType, mimeType == "application/json", let data = data {
                self.delegate?.requestDidFinish(self, receivedData: data)
            }
        }
        task.resume()
    }
}
