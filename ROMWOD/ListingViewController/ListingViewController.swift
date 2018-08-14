//
//  ListingViewController.swift
//  ROMWOD
//
//  Created by Tim Ludikar on 2018-07-24.
//  Copyright © 2018 Tim Ludikar. All rights reserved.
//

import UIKit

class ListingViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let httpClient = HTTPClient()
//    var videoList: VideoList
    var data = [ScheduleResponse]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchSchedule()
    }
    
    private func fetchSchedule(){
        let req = ScheduleRequest()
        
        httpClient.getSchedule(from: req.url) { results in
            switch results {
            case let .success(returnedValue):
                self.data = returnedValue.response
//                self.videoList = returnedValue.response
                self.reloadCollectionView()
            case let .failure(errorValue):
                print(errorValue)
            }
        }
    }
    
    private func reloadCollectionView(){
        collectionView.reloadData()
        collectionView.collectionViewLayout.invalidateLayout()
    }
}

extension ListingViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if ((self.data.first?.workouts) != nil) {
            return (self.data.first?.workouts.count)!
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "videoThumbnail", for: indexPath) as! VideoThumbnail

        guard let workoutItem = self.data.first?.workouts[indexPath.row] else { return cell }
        
        let data = try? Data(contentsOf: workoutItem.video.thumbnail.url)
        
        cell.displayContent(title: workoutItem.name, date: workoutItem.date, description: workoutItem.description, thumbnail: data!)
        return cell
    }
}
