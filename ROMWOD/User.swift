//
//  User.swift
//  ROMWOD
//
//  Created by Tim Ludikar on 2018-07-16.
//  Copyright © 2018 Tim Ludikar. All rights reserved.
//

import Foundation

class User {
//    lazy var userProfile = Profile()
    var isLoggedIn = false
    
    static func createProfile(userNameFromSignin username: String, passwordFromSignin password: String) -> User {
        let user = User()
//        user.userProfile = Profile(username)
        return user
    }
    
    func logUserIn(){
        self.isLoggedIn = true
    }
    
    func logUserOut(){
        self.isLoggedIn = false
    }
}
