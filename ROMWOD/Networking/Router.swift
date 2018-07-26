//
//  Router.swift
//  ROMWOD
//
//  Created by Tim Ludikar on 2018-07-24.
//  Copyright © 2018 Tim Ludikar. All rights reserved.
//

import Foundation

protocol Router {
    var session: URLSession { get }
    func fetch(with request: URLRequest, completion: @escaping((Result) -> Void ))
}

extension Router {
    var checkIfCookiesAreSet: [HTTPCookie]? {
        return HTTPCookieStorage.shared.cookies(for: URL(string: String("app.romwod.com"))!)
    }
    
    private func getIndexRequest(to url: URL){
        let (_, response, _) = URLSession.shared.synchronousDataTask(with: url)
        
        switch ((response as? HTTPURLResponse)!.statusCode) {
        case 200...299:
            return
        default:
            break
        }
    }
    
    func fetch(with request: URLRequest, completion: @escaping((Result) -> Void)) {
        let task = session.dataTask(with: request){ data, response, error in
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(Result.failure)
                return
            }
            
            if !((data?.isEmpty)!) {
                completion(Result.success(data!))
            } else {
                completion(.failure)
            }
        }
        task.resume()
    }
    
    func buildRequestMethod(with url: URLRequest, completionHandler: @escaping(Data?, URLResponse?, Error?) -> Void ) -> URLSessionTask {
        return URLSession.shared.dataTask(with: url){ completionHandler($0, $1, $2) }
    }

}
