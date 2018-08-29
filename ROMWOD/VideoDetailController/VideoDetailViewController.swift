//
//  VideoDetailViewController.swift
//  ROMWOD
//
//  Created by Tim Ludikar on 2018-08-28.
//  Copyright © 2018 Tim Ludikar. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class VideoDetailViewController: UIViewController {
    
    var workout: ScheduledWorkouts?
    var videoOptions: [Asset]?
    @IBOutlet weak var playBackButton: UIButton!
    
    @IBAction func playVideo(_ sender: UIButton) {

        let player = AVPlayer(playerItem: self.createAVPlayerItem(from: "hls_video", at: "720p"))
        let vc = AVPlayerViewController()
        vc.player = player
        present(vc, animated: true) {
            vc.player!.play()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let externalId = workout?.video.externalId, let slug = workout?.video.slug else { return }
        let request = "https://fast.wistia.com/embed/medias/\(externalId).json"
        let url = URL(string: request)!
        var req = URLRequest(url: url)
        req.addValue("https://app.romwod.com/workout/\(slug)", forHTTPHeaderField: "Referer")
        
        HTTPClient().getVideoDetails(from: req) { result in
            switch result {
            case let .success(data):
                self.videoOptions = data.media.assets
                self.playBackButton.isEnabled = true
            case .failure(_):
                print("error")
            }
        }
    }
    
    private func createAVPlayerItem(from type: String, at quality: String) -> AVPlayerItem{
        let video = videoOptions?.filter({ (videoInfo) -> Bool in
            videoInfo.type == type && videoInfo.displayName == quality
        }).first!
        
        let videoAsset = AVAsset(url: (video?.url)!)
        return AVPlayerItem(asset: videoAsset)
    }
}
