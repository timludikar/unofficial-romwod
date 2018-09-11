//
//  VideoDetailViewController.swift
//  ROMWOD
//
//  Created by Tim Ludikar on 2018-08-28.
//  Copyright © 2018 Tim Ludikar. All rights reserved.
//

import UIKit
import AVKit
//import AVFoundation

class VideoDetailViewController: UIViewController {
    
    var workout: ScheduledWorkouts?
    var videoOptions: [Asset]?
    var videoPlayerController = AVPlayerViewController()
    
    
    @IBOutlet weak var videoThumbnail: RWVideoThumbnail!
    
    private func createVideoLayer() {
        let player = AVPlayer(playerItem: self.createAVPlayerItem(from: "hls_video", at: "1080p"))
        videoPlayerController.player = player
        videoPlayerController.view.frame = videoThumbnail.videoThumbnail.bounds
        addChildViewController(videoPlayerController)
        videoPlayerController.player?.automaticallyWaitsToMinimizeStalling = true
        videoPlayerController.player?.play()
        videoThumbnail.videoThumbnail.addSubview(videoPlayerController.view)
    }
    
    private func setup(){
        guard let workout = workout else { return }
        let duration = Int((workout.video.durationInSeconds / 60).rounded())
        videoThumbnail.videoDuration.text = "\(duration) Min".uppercased()
    }
    
    private func setupVideoDetails(){
        ImageLibrary().fetch(from: (workout?.video.thumbnail.url)!) { (image) in
            DispatchQueue.main.async {
                self.videoThumbnail.thumbnailImage.image = image
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupVideoDetails()
        videoThumbnail.delegate = self
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
                self.videoOptions = data.media.assets

            case .failure(_):
                print("error")
            }
        }
    }
    
    private func createAVPlayerItem(from type: String, at quality: String) -> AVPlayerItem{
        let video = videoOptions?.filter({ (videoInfo) -> Bool in
            videoInfo.type == type && videoInfo.displayName == quality
        }).first!
        
        let url = video?.url.appendingPathExtension((video?.extType)!)
        let videoAsset = AVURLAsset(url: url!)
        return AVPlayerItem(asset: videoAsset)
    }
}

extension VideoDetailViewController: RWVideoThumbnailDelegate {
    func video(_ video: RWVideoThumbnail, didSelectPlayButton index: Bool) {
        createVideoLayer()
        print("Video Selected")
    }
}
