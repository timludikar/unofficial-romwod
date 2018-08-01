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
                DispatchQueue.main.async {
                    let workouts = returnedValue.response.first as? ScheduleResponse
                    
                    guard let today = workouts?.find(today: "2018-07-30T00:00:00.000Z").first else {
                        return
                    }
                    
                    print(self.view.subviews)
                    
                    print(today.name)
//                    let detail = UIVideoThumbnail(frame: CGRect.zero)
//                    self.view.addSubview(detail)
//                    detail.title.text = "TEST"
//                    detail.date.text = today.date
//                    detail.desc.text = today.description
                    
                    
                }

//                print(returnedValue.response.find(today: "2018-07-30T00:00:00.000Z"))
            case let .failure(errorValue):
                print(errorValue)
            }
        }
    }
}
