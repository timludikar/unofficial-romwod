//
//  ListingViewController.swift
//  ROMWOD
//
//  Created by Tim Ludikar on 2018-07-24.
//  Copyright © 2018 Tim Ludikar. All rights reserved.
//

import UIKit

extension Date {
    func userDate() -> String {
        let calendar = Calendar.current
        let year = calendar.component(.year, from: self)
        let month = calendar.component(.month, from: self)
        let day = calendar.component(.day, from: self)
        return "\(year)-\(month)-\(day)"
    }
}

class ListingViewController: UIViewController {
    
    let httpClient = HTTPClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let req = ScheduleRequest()
        
        httpClient.getSchedule(from: req.url) { results in
            switch results {
            case let .success(returnedValue):
                print(returnedValue)
            case let .failure(errorValue):
                print(errorValue)
            }
        }
    }
}
