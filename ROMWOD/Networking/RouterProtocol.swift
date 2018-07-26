//
//  RouterProtocol.swift
//  ROMWOD
//
//  Created by Tim Ludikar on 2018-07-25.
//  Copyright © 2018 Tim Ludikar. All rights reserved.
//

import Foundation

protocol RouterDelegate: class {
    var router: Router? { get }
    func requestDidFinish(_ sender: Router, receivedData data: Data?)
    func requestFailed(_ sender: Router, error: Error)
}

extension RouterDelegate {}
