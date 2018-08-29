//
//  VideoList.swift
//  ROMWOD
//
//  Created by Tim Ludikar on 2018-08-14.
//  Copyright © 2018 Tim Ludikar. All rights reserved.
//

import Foundation
import UIKit

protocol VideoListDelegate: class {
    func videoList(_ videoList: VideoList, didFinishWith data: [ScheduleResponse])
    func videoList(_ videoList: VideoList, didCancelWith error: Error)
}

class VideoList {
    weak var delegate: VideoListDelegate?
    lazy var workouts = [ScheduledWorkouts]()
    let httpClient = HTTPClient()
    
    init(withDelegate delegate: VideoListDelegate?) {
        self.delegate = delegate
    }
    
//    func fetchThumbnail(for workout: ScheduledWorkouts, completion: @escaping(UIImage) -> Void) {
//        if let image = imageCache.cachedResponse(for: URLRequest(url: workout.video.thumbnail.url)){
//            completion(UIImage(data: image.data)!)
//        } else {
//            URLSession.shared.dataTask(with: workout.video.thumbnail.url){ (data, response, error) in
//                guard let data = data else { return }
//                let cache = CachedURLResponse(response: response!, data: data)
//                imageCache.storeCachedResponse(cache, for: URLRequest(url: workout.video.thumbnail.url))
//                let image = UIImage(data: data)!
//                completion(image)
//                }.resume()
//        }
//    }
    
    func populateSchedule(with date: String) {
        let req = ScheduleRequest(userDate: date, archived: false)
        
        httpClient.getSchedule(from: req.url) { results in
            switch results {
            case let .success(data):

                guard let schedule = data.response.first else {
                    return
                }

                self.workouts = schedule.workouts
                self.delegate?.videoList(self, didFinishWith: data.response as [ScheduleResponse])
            case let .failure(errorValue):
                print(errorValue)
            }
        }
    }
}
