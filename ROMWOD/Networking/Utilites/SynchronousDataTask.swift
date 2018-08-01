//
//  SyncWithData.swift
//  ROMWOD
//
//  Created by Tim Ludikar on 2018-07-25.
//  Copyright © 2018 Tim Ludikar. All rights reserved.
//

import Foundation

extension URLSession {
    func synchronousDataTask(with url: URL) -> (Data?, URLResponse?, Error?){
        var data: Data?
        var response: URLResponse?
        var error: Error?
        
        let semaphore = DispatchSemaphore(value: 0)
        
        let task = self.dataTask(with: url){
            data = $0
            response = $1
            error = $2
            semaphore.signal()
        }
        
        task.resume()
        
        _ = semaphore.wait(timeout: .distantFuture)
        
        return (data, response, error)
    }
}
