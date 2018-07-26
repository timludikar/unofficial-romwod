//
//  Router.swift
//  ROMWOD
//
//  Created by Tim Ludikar on 2018-07-24.
//  Copyright © 2018 Tim Ludikar. All rights reserved.
//

import Foundation

enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
}

class Router {
    weak var delegate: RouterDelegate?
    
    private func checkIfCookiesAreSet() -> [HTTPCookie]? {
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
    
    func buildRequestMethod(with url: URLRequest, completionHandler: @escaping(Data?, URLResponse?, Error?) -> Void ) -> URLSessionTask {
        return URLSession.shared.dataTask(with: url){ completionHandler($0, $1, $2) }        
    }
  
    func makeRequest(to url: URLRequest){
        if checkIfCookiesAreSet()?.isEmpty == true {
            getIndexRequest(to: URL(string: ROMWOD.APP)!)
        }
        
        let task = buildRequestMethod(with: url){ data, response, error in
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
