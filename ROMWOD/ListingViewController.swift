//
//  ListingViewController.swift
//  ROMWOD
//
//  Created by Tim Ludikar on 2018-07-24.
//  Copyright © 2018 Tim Ludikar. All rights reserved.
//

import UIKit

class ListingViewController: UIViewController, RouterDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let req = RequestData("https://app.romwod.com", path: "/api/v1/weekly_schedules?archived=false&user_date=2018-7-24")
        let router = Router()
        router.delegate = self
        router.makeRequest(to: req)
    }

    func requestFailed(_ sender: Router, error: Error) {
        print(error)
    }
    
    func requestDidFinish(_ sender: Router, receivedData data: Data?) {
        if let data = data, let result = String(data: data, encoding: .utf8) {
            print("RECEIVED! \(result)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
