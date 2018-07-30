//
//  Profile.swift
//  ROMWOD
//
//  Created by Tim Ludikar on 2018-07-16.
//  Copyright © 2018 Tim Ludikar. All rights reserved.
//

import Foundation

struct ProfileResponse: Decodable {
    var id: Int
    var first_name: String
    var last_name: String
    var email: String
    var username: String
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case id
        case first_name
        case last_name
        case email
        case username
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self).nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        id = try container.decode(Int.self, forKey: .id)
        first_name = try container.decode(String.self, forKey: .first_name)
        last_name = try container.decode(String.self, forKey: .last_name)
        email = try container.decode(String.self, forKey: .email)
        username = try container.decode(String.self, forKey: .username)
    }
}

//{"data":{"id":159056,"first_name":"Tim","last_name":"Ludikar","email":"tludikar@gmail.com","confirmed_at":"2018-05-09T23:03:58.000Z","username":"timludikar","tos":true,"state":"active","uid":"tludikar@gmail.com","provider":"email","source":"web","business_name":null,"website":null,"phone":"+16478845895","business_phone":null,"paypal_email":null,"address1":null,"address2":null,"city":null,"state_abbr":null,"zip_code":null,"country":null,"role":"user","affiliate?":false,"referral_code":null,"max_devices":2,"vip":false,"fbid":null,"twid":null,"goid":null,"user_timezone":null,"subscription":{"id":210683,"user_id":159056,"source":"web","trial_started_at":null,"trial_ends_at":null,"current_period_started_at":"2018-06-17T10:47:14.000+00:00","current_period_ends_at":"2018-07-17T10:47:14.000+00:00","state":"active","postpone_end_date":null,"postponed_period":null,"postponed_on":null,"canceled_on":null,"expires_at":null,"plan":{"id":8,"name":"Athlete - Monthly","description":"This is the monthly test plan","code":"athlete-monthly","plan_interval_length":1,"trial_interval_length":7,"plan_interval_unit":"months","trial_interval_unit":"days","amount_in_cents":{"USD":1395}}},"avatar":null}}
