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
                let workouts = returnedValue.response.first as? ScheduleResponse
                
                guard let today = workouts?.find(today: "2018-07-30T00:00:00.000Z").first else {
                    return
                }
                
                guard let target = self.view.subviews.first as? UIVideoThumbnail else {
                    return
                }
                target.title.text = today.name
                target.date.text = today.date
                target.desc.text = today.description
                let dataURL = URL(string: "https://embed-ssl.wistia.com/deliveries/b0d179daccb3d714e259514bd8f9b0726a176dd3.jpg")!
                let data = try? Data(contentsOf: dataURL)
                target.thumbnail.image = UIImage(data: data!)
                print(today)
            case let .failure(errorValue):
                print(errorValue)
            }
        }
    }
}
