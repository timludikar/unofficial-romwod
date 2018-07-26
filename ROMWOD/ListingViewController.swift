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

        let req = ScheduleRequest(dateOf: Date().userDate())
        print(req.url)
        
//        let request = httpRequest(proto: "https://", base: "app.romwod.com/api/v1/weekly_schedules?archived=false&user_date=\(Date().userDate())", method: HTTPMethod.get)
//        let url = URL(string: "https://app.romwod.com/api/v1/weekly_schedules?archived=false&user_date=2018-7-24")!
//        let request = URLRequest(url: url)
//
//
        
//        self.router = Router()
//        self.router?.delegate = self
//        self.router?.makeRequest(to: request)
    }

    func requestFailed(_ sender: Router, error: Error) {
        print(error)
    }
    
    func requestDidFinish(_ sender: Router, receivedData data: Data?) {
        if let data = data, let result = String(data: data, encoding: .utf8) {
            print("\n\n\nRECEIVED! \(result)")
        }
    
    }
}
