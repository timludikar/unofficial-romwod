//
//  VideoDetailViewController.swift
//  ROMWOD
//
//  Created by Tim Ludikar on 2018-08-28.
//  Copyright © 2018 Tim Ludikar. All rights reserved.
//

import UIKit
import AVKit

var videoViewController: RWVideoPlayer?
var window: UIWindow?

class VideoDetailViewController: UIViewController {
    
    var workout: ScheduledWorkouts?
    var videoOptions: [Asset]?
    var videoPlayerController = AVPlayerViewController()
    var externalVideoDisplay = false
    
    @IBOutlet weak var videoThumbnail: RWVideoThumbnail!
    
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
    
    private func addVideo(){
        videoViewController?.setViewControllerSize(videoThumbnail.videoThumbnail.bounds)
        addChildViewController(videoViewController!)
        videoThumbnail.videoThumbnail.addSubview((videoViewController?.view)!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupVideoDetails()
        
        if(videoViewController != nil) {
            addVideo()
        }
        
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
}

extension VideoDetailViewController: RWVideoThumbnailDelegate {
    func video(_ video: RWVideoThumbnail, didSelectPlayButton index: Bool) {
        if(videoViewController == nil) {
            videoViewController = RWVideoPlayer()
        }
        videoViewController?.videoOptions = videoOptions
        addVideo()
        videoViewController?.playVideo()
    }
}
