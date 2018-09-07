
//  ListingViewController.swift
//  ROMWOD
//
//  Created by Tim Ludikar on 2018-07-24.
//  Copyright © 2018 Tim Ludikar. All rights reserved.
//

import UIKit

class ListingViewController: UIViewController {
    
    private var selectedWorkout: ScheduledWorkouts?

    @IBOutlet weak var calendarSelector: RWCalendar!
    @IBOutlet weak var dateSelector: RWTitleBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    lazy var videoList = VideoList(withDelegate: self)
    private var selectedWeek = Date()
    
    private func updateDateSelector() -> Void {
        dateSelector.dateLabel.setRange(startDate: selectedWeek.startOfWeek!, endDate: selectedWeek.endOfWeek!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendarSelector.delegate = self
        collectionView.delegate = self
        videoList.populateSchedule(with: selectedWeek)
        dateSelector.dateLabel.setRange(startDate: selectedWeek.startOfWeek!, endDate: selectedWeek.endOfWeek!)
    }
    
    private func reloadCollectionView(){
        collectionView.reloadData()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is VideoDetailViewController {
            let vc = segue.destination as? VideoDetailViewController
            vc?.workout = self.selectedWorkout
//
//            videoList.fetchThumbnail(for: self.selectedWorkout!) {[weak vc](image) in
//                DispatchQueue.main.async {
//                    vc?.thumbnailImage.image = image
//                }
//            }
            
//            vc?.thumbnailImage = self.selectedWorkout?.video.thumbnail.url
        }
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
            
            let videoThumbnail = RWVideoThumbnail(frame: cell.bounds)
            videoThumbnail.dateHeader.text = workoutItem.date.formattedDate
            videoThumbnail.videoTitle.text = workoutItem.name
            videoThumbnail.videoDescription.text = workoutItem.description
            
            let duration = Int((workoutItem.video.durationInSeconds / 60).rounded())
            
            videoThumbnail.videoDuration.text = "\(duration) Min".uppercased()
//            let videoThumbnail = RWVideoThumbnail(frame: cell.bounds)
//            let videoThumbnail = UIVideoThumbnail(frame: cell.bounds, workout: workoutItem)
            
            
            ImageLibrary().fetch(from: workoutItem.video.thumbnail.url) { [weak videoThumbnail](image) in
                DispatchQueue.main.async {
                    videoThumbnail?.thumbnailImage.image = image
                }
            }
            
//            videoList.fetchThumbnail(for: workoutItem) {[weak videoThumbnail](image) in
//                DispatchQueue.main.async {
//                    videoThumbnail?.thumbnail.image = image
//                }
//            }
            
            cell.videoThumbnail = videoThumbnail
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        self.selectedWorkout = videoList.workouts[indexPath.item]
//        self.performSegue(withIdentifier: "ShowVideoSegue", sender: self)
        
//        guard let cell = collectionView.cellForItem(at: indexPath) as? VideoThumbnail else { return }
//        videoList.workouts[indexPath.item].isHidden = !(videoList.workouts[indexPath.item].isHidden)
//        if(videoList.workouts[indexPath.item].isHidden == true){
//            cell.videoThumbnail?.hideDate()
//        } else {
//            cell.videoThumbnail?.showDate()
//        }
    }
}

extension ListingViewController: RWCalendarEventDelegate {
    func calendarEvent(_ calendarEvent: RWCalendar, didSelectItemAt indexPath: Int) {
        let i = IndexPath(item: indexPath, section: 0)
        collectionView.scrollToItem(at: i, at: .top, animated: true)
    }
}
