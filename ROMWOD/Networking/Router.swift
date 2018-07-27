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
    func fetch<T: Decodable>(with request: URLRequest, completion: @escaping((Result<T, RequestError>) -> Void ))
    func upload<T: Encodable, S: Decodable>(with request: URLRequest, from uploadData: T, completion: @escaping((Result<S, RequestError>) -> Void ))
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
    
    func upload<T: Encodable, S: Decodable>(with request: URLRequest, from uploadData: T, completion: @escaping((Result<S, RequestError>) -> Void )){
        let requestData = try? JSONEncoder().encode(uploadData)
        let task = session.uploadTask(with: request, from: requestData!){ data, response, error in
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(Result.failure(RequestError.requestFailed))
                return
            }
            
            guard let result = try? JSONDecoder().decode(S.self, from: data!) else {
                completion(Result.failure(RequestError.jsonParseError))
                return
            }
            completion(Result.success(result))
        }
        task.resume()
    }
    
    func fetch<T: Decodable>(with request: URLRequest, completion: @escaping((Result<T, RequestError>) -> Void )) {
        let task = session.dataTask(with: request){ data, response, error in
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(Result.failure(RequestError.requestFailed))
                return
            }
            
            guard let result = try? JSONDecoder().decode(T.self, from: data!) else {
                completion(Result.failure(RequestError.jsonParseError))
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
