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

class ListingViewController: UIViewController, RouterDelegate {
    
    var router: Router?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let wo = Workouts(configuration: URLSessionConfiguration.default)
        let req = ScheduleRequest(dateOf: Date().userDate())
        let urlRequest = URLRequest(url: req.url)
        
        wo.getAll(from: urlRequest){ result in
            switch result {
            case let .success(returnedValue):
                print(returnedValue)
            default:
                break
            }
        }
    }

    func requestFailed(_ sender: Router, error: Error) {
        print(error)
    }
    
    func requestDidFinish(_ sender: Router, receivedData data: Data?) {
        if let data = data {
            guard let result = try? JSONDecoder().decode(ResponseData.self, from: data) else {
                return 
            }
            
            for item in result.response {
                print(item.id)
            }
        }
    
    }
}
