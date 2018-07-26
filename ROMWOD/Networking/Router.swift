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
    func fetch<T: Decodable>(with request: URLRequest, completion: @escaping((Result<T>) -> Void ))
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
    
    func fetch<T: Decodable>(with request: URLRequest, completion: @escaping((Result<T>) -> Void )) {
        let task = session.dataTask(with: request){ data, response, error in
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(Result.failure)
                return
            }
            
            guard let result = try? JSONDecoder().decode(T.self, from: data!) else {
                return
            }
            completion(Result.success(result))
        }
        task.resume()
    }
    
    func buildRequestMethod(with url: URLRequest, completionHandler: @escaping(Data?, URLResponse?, Error?) -> Void ) -> URLSessionTask {
        return URLSession.shared.dataTask(with: url){ completionHandler($0, $1, $2) }
    }

}
