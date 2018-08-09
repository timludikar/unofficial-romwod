//
//  ListingViewController.swift
//  ROMWOD
//
//  Created by Tim Ludikar on 2018-07-24.
//  Copyright © 2018 Tim Ludikar. All rights reserved.
//

import UIKit

class MyCell: UICollectionViewCell {
    @IBOutlet weak var videoThumbnail: UIVideoThumbnail!
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
    }
    
    func displayContent(title: String, date: String, description: String, thumbnail: Data){
        videoThumbnail.title.text = title
        videoThumbnail.date.text = date
        videoThumbnail.desc.text = description
        videoThumbnail.thumbnail.image = UIImage(data: thumbnail)
    }
}

class ListingViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let httpClient = HTTPClient()
    var data = [ScheduleResponse]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let req = ScheduleRequest()
        
        httpClient.getSchedule(from: req.url) { results in
            switch results {
            case let .success(returnedValue):
                self.data = returnedValue.response
                self.collectionView.reloadData()
            case let .failure(errorValue):
                print(errorValue)
            }
        }
    }
}

extension ListingViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if ((self.data.first?.workouts) != nil) {
            return (self.data.first?.workouts.count)!
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! MyCell

        guard let workoutItem = self.data.first?.workouts[indexPath.row] else { return cell }
        
        let data = try? Data(contentsOf: workoutItem.video.thumbnail.url)
        
        cell.displayContent(title: workoutItem.name, date: "\(workoutItem.date)", description: workoutItem.description, thumbnail: data!)
        return cell
    }
}
