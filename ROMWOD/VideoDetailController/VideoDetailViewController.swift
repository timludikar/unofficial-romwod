//
//  VideoDetailViewController.swift
//  ROMWOD
//
//  Created by Tim Ludikar on 2018-08-28.
//  Copyright © 2018 Tim Ludikar. All rights reserved.
//

import UIKit
import AVKit

class VideoDetailViewController: UIViewController {
    
    var workout: ScheduledWorkouts?
    var videoOptions: [Asset]?
    var videoPlayerController = AVPlayerViewController()
    var externalVideoDisplay = false
    
    @IBOutlet weak var videoPlayer: RWVideoPlayer!
    
    private func setup(){
        guard let workout = workout else { return }
//        let duration = Int((workout.video.durationInSeconds / 60).rounded())
//        videoThumbnail.videoDuration.text = "\(duration) Min".uppercased()
    }
    
    private func setupVideoDetails(){
        ImageLibrary().fetch(from: (workout?.video.thumbnail.url)!) { (image) in
            DispatchQueue.main.async {
//                self.videoThumbnail.thumbnailImage.image = image
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let nvc = UIApplication.shared.keyWindow?.rootViewController as? RWNavigationController {
            nvc.loadVideo(videoPlayer)
        }
//        if let nvc = UIApplication.shared
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupVideoDetails()
        
        if let nvc = UIApplication.shared.keyWindow?.rootViewController as? RWNavigationController {
            if let videoPlayer = nvc.stopVideo() {
                videoPlayer.frame = view.subviews[0].bounds
                view.addSubview(videoPlayer)
                self.videoPlayer = videoPlayer
//                view.addSubview(videoPlayer)
            }
        }
        
        guard let externalId = workout?.video.externalId, let slug = workout?.video.slug else { return }
        let request = "https://fast.wistia.com/embed/medias/\(externalId).json"
        let url = URL(string: request)!
        var req = URLRequest(url: url)
        req.addValue("https://app.romwod.com/workout/\(slug)", forHTTPHeaderField: "Referer")
        
        HTTPClient().getVideoDetails(from: req) { result in

            switch result {
            case let .success(data):
                DispatchQueue.main.async {
//                    self.playBackButton.isEnabled = true
                    
                }
                self.videoPlayer.videoOptions = data.media.assets
                let playerItem = self.videoPlayer.createAVPlayerItem(from: "hls_video", at: "1080p")
                self.videoPlayer.player = AVQueuePlayer(playerItem: playerItem)
                self.videoPlayer.player?.play()
                
                
            case .failure(_):
                print("error")
            }
        }
    }
}

