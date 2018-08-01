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
    
    private func getIndexRequest(){
        let url = URL(string: ROMWOD.APP)!
        let (_, response, _) = URLSession.shared.synchronousDataTask(with: url)
        
        switch ((response as? HTTPURLResponse)!.statusCode) {
        case 200...299:
            return
        default:
            break
        }
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
    
    private func resultValidation<T: Decodable>(data: Data?, response: URLResponse?, error: Error?, completion: @escaping((Result<T, RequestError>) -> Void)) {
        DispatchQueue.main.async {
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
    }
    
    func upload<T: Encodable, S: Decodable>(with request: URLRequest, from uploadData: T, completion: @escaping((Result<S, RequestError>) -> Void )){
        checkIfCookiesAreSet!.isEmpty ? getIndexRequest() : ()
    
        guard let requestData = try? JSONEncoder().encode(uploadData) else {
            return
        }
        
        let task = URLSession.shared.uploadTask(with: request, from: requestData){ self.resultValidation(data: $0, response: $1, error: $2, completion: completion) }
        task.resume()
    }
    
    func fetch<T: Decodable>(with request: URLRequest, completion: @escaping((Result<T, RequestError>) -> Void )) {
        checkIfCookiesAreSet!.isEmpty ? getIndexRequest() : ()
        let task = URLSession.shared.dataTask(with: request){ self.resultValidation(data: $0, response: $1, error: $2, completion: completion) }
        task.resume()
    }
}
