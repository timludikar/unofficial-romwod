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
    func upload<S: Decodable, T: Encodable>(with request: URLRequest, from uploadData: T, completion: @escaping((Result<S, RequestError>) -> Void ))
}

extension Router {
    var checkIfCookiesAreSet: [HTTPCookie]? {
        return HTTPCookieStorage.shared.cookies(for: URL(string: String("app.romwod.com"))!)
    }
    
    private func responseValidation(response: URLResponse?) -> ResponseType {
        guard let response = response as? HTTPURLResponse else {
            return .invalid(error: RequestError.requestFailed)
        }
        
        switch (response.statusCode, response.mimeType) {
        case (401,"application/json"):
            return .invalid(error: RequestError.authenicationError)
        case (200...299, "application/json"):
            return .valid
        default:
            return .invalid(error: RequestError.unknownError)
        }
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
        let url = URL(string: ROMWOD.APP)!
        checkIfCookiesAreSet!.isEmpty ? getIndexRequest(to: url) : ()
    
        guard let requestData = try? JSONEncoder().encode(uploadData) else {
            return
        }
        
        let task = URLSession.shared.uploadTask(with: request, from: requestData){data, response, error in
            switch (self.responseValidation(response: response)) {
            case .valid:
                guard let result = try? JSONDecoder().decode(S.self, from: data!) else {
                    completion(Result.failure(RequestError.jsonParseError))
                    return
                }
                completion(Result.success(result))
            case .invalid(let error):
                completion(Result.failure(error))
            }
        }
        task.resume()
    }
    
    func fetch<T: Decodable>(with request: URLRequest, completion: @escaping((Result<T, RequestError>) -> Void )) {
        let url = URL(string: ROMWOD.APP)!
        checkIfCookiesAreSet!.isEmpty ? getIndexRequest(to: url) : ()
        let task = URLSession.shared.dataTask(with: request){ data, response, error in
            switch (self.responseValidation(response: response)) {
            case .valid:
                guard let result = try? JSONDecoder().decode(T.self, from: data!) else {
                    completion(Result.failure(RequestError.jsonParseError))
                    return
                }
                completion(Result.success(result))
            case .invalid(let error):
                completion(Result.failure(error))
            }
        }
        task.resume()
    }
}
