//
//  Request.swift
//  ROMWOD
//
//  Created by Tim Ludikar on 2018-08-14.
//  Copyright © 2018 Tim Ludikar. All rights reserved.
//

import Foundation

enum RequestError: Error {
    case requestFailed
    case jsonParseError
    case authenicationError
    case unknownError
}

protocol Request: Encodable {
    var url: URLRequest { get }
}
