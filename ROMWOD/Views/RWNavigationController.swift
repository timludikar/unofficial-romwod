//
//  RWNavigationController.swift
//  ROMWOD
//
//  Created by Tim Ludikar on 2018-09-12.
//  Copyright © 2018 Tim Ludikar. All rights reserved.
//

import UIKit
import AVFoundation


@IBDesignable
class RWNavigationController: UINavigationController {

    var videoToolbar: UIView?
    var videoPlayer: RWVideoPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()

        let videoToolBarView = UIView()
        videoToolBarView.isHidden = true
        view.addSubview(videoToolBarView)
        videoToolBarView.backgroundColor = UIColor.blue
        videoToolBarView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            videoToolBarView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.0),
            videoToolBarView.heightAnchor.constraint(equalToConstant: 60),
            videoToolBarView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        self.videoToolbar = videoToolBarView
    }
    
    func stopVideo() -> RWVideoPlayer? {
        guard let videoPlayer = self.videoPlayer else { return nil }
        self.videoPlayer?.player?.pause()
        self.videoPlayer = nil
        videoToolbar?.isHidden = true
        return videoPlayer
    }
    
    
    func loadVideo(_ player: RWVideoPlayer){
        videoToolbar?.isHidden = false
        self.videoPlayer = player
        guard let videoToolbar = videoToolbar, let videoPlayer = self.videoPlayer else { return }
        let ratio = CGFloat(16.0/9.0)
        videoPlayer.frame = CGRect(x: 0.0, y: 0.0, width: (videoToolbar.bounds.size.height * ratio), height: videoToolbar.bounds.size.height)
        videoPlayer.translatesAutoresizingMaskIntoConstraints = false
        videoToolbar.addSubview(videoPlayer)

        NSLayoutConstraint.activate([
            videoPlayer.topAnchor.constraint(equalTo: videoToolbar.topAnchor),
            videoPlayer.trailingAnchor.constraint(equalTo: videoToolbar.trailingAnchor),
            videoPlayer.heightAnchor.constraint(equalTo: videoToolbar.heightAnchor, multiplier: 1.0),
            NSLayoutConstraint(item: videoPlayer,
                               attribute: NSLayoutAttribute.height,
                               relatedBy: NSLayoutRelation.equal,
                               toItem: videoPlayer,
                               attribute: NSLayoutAttribute.width,
                               multiplier: videoPlayer.frame.size.height / videoPlayer.frame.size.width,
                               constant: 0)
        ])
    }

}
