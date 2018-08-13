//
//  ListingViewController.swift
//  ROMWOD
//
//  Created by Tim Ludikar on 2018-07-24.
//  Copyright © 2018 Tim Ludikar. All rights reserved.
//

import UIKit

class VideoThumbnail: UICollectionViewCell {
    @IBOutlet weak var videoThumbnail: UIVideoThumbnail!
//    lazy var width: NSLayoutConstraint = {
//        let width = contentView.widthAnchor.constraint(equalToConstant: bounds.size.width)
//        width.isActive = true
//        return width
//    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        contentView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
//    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
//        width.constant = bounds.size.width
//        return contentView.systemLayoutSizeFitting(CGSize(width: targetSize.width, height: 1))
//    }
    
    func displayContent(title: String, date: Date, description: String, thumbnail: Data){
        videoThumbnail.title.text = title
        videoThumbnail.setDate(to: date)
        videoThumbnail.desc.text = description
        videoThumbnail.setImage(to: thumbnail)
    }
}

class ListingViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let httpClient = HTTPClient()
    var data = [ScheduleResponse]()
    
//    var layout: UICollectionViewFlowLayout = {
//        let layout = UICollectionViewFlowLayout()
//        let width = UIScreen.main.bounds.size.width
//        layout.estimatedItemSize = CGSize(width: width, height: 10)
//        return layout
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchSchedule()
        
//        collectionView?.register(VideoThumbnail.self, forCellWithReuseIdentifier: "videoThumbnail")
//        collectionView.collectionViewLayout = layout
    }
    
    private func fetchSchedule(){
        let req = ScheduleRequest()
        
        httpClient.getSchedule(from: req.url) { results in
            switch results {
            case let .success(returnedValue):
                self.data = returnedValue.response
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
