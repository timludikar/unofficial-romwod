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
                
                guard let workouts = returnedValue.response.first else {
                    return
                }

                for (index, workout) in workouts.workouts.enumerated() {
                    let nuView = UIVideoThumbnail(frame: CGRect(x: 0, y: (0 + (170 * index)), width: Int(self.view.frame.width), height: 168))
                    
                    nuView.title.text = workout.name
                    nuView.date.text = workout.date
                    nuView.desc.text = workout.description
                    let dataURL = URL(string: workout.video.thumbnail.url)!
                    let data = try? Data(contentsOf: dataURL)
                    
                    nuView.thumbnail.image = UIImage(data: data!)
                    self.view.addSubview(nuView)
                }
            case let .failure(errorValue):
                print(errorValue)
            }
        }
    }
}
