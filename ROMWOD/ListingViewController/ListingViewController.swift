
//  ListingViewController.swift
//  ROMWOD
//
//  Created by Tim Ludikar on 2018-07-24.
//  Copyright © 2018 Tim Ludikar. All rights reserved.
//

import UIKit

class ListingViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    lazy var videoList = VideoList(withDelegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        videoList.populateSchedule(with: Date().userDate())
    }
    
    private func reloadCollectionView(){
        collectionView.reloadData()
        collectionView.collectionViewLayout.invalidateLayout()
    }
}

extension ListingViewController: VideoListDelegate {
    func videoList(_ videoList: VideoList, didFinishWith data: [ScheduleResponse]) {
        self.reloadCollectionView()
    }
    
    func videoList(_ videoList: VideoList, didCancelWith error: Error) {
        print(error)
    }
}

extension ListingViewController: UICollectionViewDataSource {
    
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "videoThumbnail", for: indexPath) as! VideoThumbnail
            let workoutItem = self.videoList.workouts[indexPath.row]
            print("Adding \(indexPath.row)")
            
            videoList.fetchThumbnail(for: workoutItem) { (image) in
                DispatchQueue.main.async {
                    cell.videoThumbnail?.thumbnail.image = image
                }
            }
            
            cell.videoThumbnail?.desc.text = workoutItem.description
            cell.videoThumbnail?.title.text = workoutItem.name

            return cell
    }
}

extension ListingViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if((self.videoList.workouts.first) != nil) {
            return (self.videoList.workouts.count)
        }
        return 0
    }
}
