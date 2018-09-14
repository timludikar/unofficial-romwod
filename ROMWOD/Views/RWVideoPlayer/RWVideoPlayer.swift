//
//  RWVideoPlayer.swift
//  ROMWOD
//
//  Created by Tim Ludikar on 2018-09-12.
//  Copyright © 2018 Tim Ludikar. All rights reserved.
//

import Foundation
import AVKit

class RWVideoPlayer: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    var player: AVPlayer? {
        get {
            return playerLayer.player
        }
        set {
            playerLayer.player = newValue
        }
    }
    
    var playerLayer: AVPlayerLayer {
        return layer as! AVPlayerLayer
    }
    
    var videoOptions: [Asset]?
    var playButton: UIButton?
    var thumbnail: UIImageView? {
        didSet {
            guard let thumbnail = thumbnail, let playButton = playButton else { return }
            thumbnail.frame = playerLayer.bounds
            self.insertSubview(thumbnail, belowSubview: playButton)
        }
    }
    
    // Override UIView property
    override static var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
    
    private func setupView(){
        let playButton = UIButton(frame: CGRect(x: 0, y: 0, width: 98, height: 52))
        playButton.setBackgroundImage(UIImage(named: "Play Button"), for: .normal)
        playButton.addTarget(self, action: #selector(self.playVideo(_:)), for: .touchUpInside)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(playButton)
        
        NSLayoutConstraint.activate([
            playButton.widthAnchor.constraint(lessThanOrEqualToConstant: 98),
            playButton.heightAnchor.constraint(lessThanOrEqualToConstant: 52),
            playButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            playButton.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        self.playButton = playButton
    }
    
    @objc func playVideo(_ sender: UITapGestureRecognizer){
        guard let playButton = self.playButton else { return }
        playButton.isHidden = true
        
        playerLayer.player?.play()
        
        let pauseTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.pauseVideo(_:)))
        self.addGestureRecognizer(pauseTapGesture)
    }
    
    @objc func pauseVideo(_ sender: UITapGestureRecognizer){
        guard let videoPlayer = player, let playButton = playButton else { return }

        self.gestureRecognizers?.forEach(self.removeGestureRecognizer)
        videoPlayer.pause()
        playButton.isHidden = false
    }
    
    // Move to Model
    func createAVPlayerItem(from type: String, at quality: String) -> AVPlayerItem{
        let video = videoOptions?.filter({ (videoInfo) -> Bool in
            videoInfo.type == type && videoInfo.displayName == quality
        }).first!
        
        let url = video?.url.appendingPathExtension((video?.extType)!)
        let videoAsset = AVAsset(url: url!)
        return AVPlayerItem(asset: videoAsset)
    }
    
}
