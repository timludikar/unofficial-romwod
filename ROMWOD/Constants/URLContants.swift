//
//  NetworkURL.swift
//  ROMWOD
//
//  Created by Tim Ludikar on 2018-07-25.
//  Copyright © 2018 Tim Ludikar. All rights reserved.
//

import Foundation

struct ROMWOD {
    private struct DOMAINS {
        static let PROD = "https://app.romwod.com"
    }
    
    private struct ROUTES {
        static let API = "/api/v1/"
        static let WEEKLY = API + "weekly_schedules"
        static let SIGNIN = API + "/auth/sign_in"
    }
    
    static var APP: String {
        return DOMAINS.PROD
    }
    
    static var API: String {
        return DOMAINS.PROD + ROUTES.API
    }
    
    static var WEEKLY: String {
        return DOMAINS.PROD + ROUTES.WEEKLY
    }
    
    static var SIGNIN: String {
        return DOMAINS.PROD + ROUTES.SIGNIN
    }
    
}
