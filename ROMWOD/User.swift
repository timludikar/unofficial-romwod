//
//  User.swift
//  ROMWOD
//
//  Created by Tim Ludikar on 2018-07-16.
//  Copyright © 2018 Tim Ludikar. All rights reserved.
//

import Foundation

class User {
    var profile : ProfileResponse?
    var isLoggedIn = false
    
    static func createProfile(from profile: ProfileResponse) -> User {
        let user = User()
        user.profile = profile
        user.logUserIn()
        return user
    }
    
    func logUserIn(){
        self.isLoggedIn = true
    }
    
    func logUserOut(){
        self.isLoggedIn = false
    }
}
