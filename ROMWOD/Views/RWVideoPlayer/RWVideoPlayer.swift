//
//  RWVideoPlayer.swift
//  ROMWOD
//
//  Created by Tim Ludikar on 2018-09-12.
//  Copyright © 2018 Tim Ludikar. All rights reserved.
//

import Foundation
import AVKit



class RWVideoPlayer: AVPlayerViewController {
    
    var videoOptions: [Asset]?
    var videoPlayer: AVPlayer?
    
    func setViewControllerSize(_ bounds: CGRect){
        self.view.frame = bounds
    }
    
    func playVideo() {
        createVideoLayer()
    }
    
    private func createVideoLayer() {
        let player = AVPlayer(playerItem: self.createAVPlayerItem(from: "hls_video", at: "1080p"))
        
        self.player = player
        if(videoPlayer != nil) {
            videoPlayer?.pause()
            videoPlayer = nil
        }
        videoPlayer = player
        self.player?.automaticallyWaitsToMinimizeStalling = true
        self.player?.play()
    }
    
    func modal(){
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .crossDissolve
    }
    
    
    private func createAVPlayerItem(from type: String, at quality: String) -> AVPlayerItem{
        let video = videoOptions?.filter({ (videoInfo) -> Bool in
            videoInfo.type == type && videoInfo.displayName == quality
        }).first!
        
        let url = video?.url.appendingPathExtension((video?.extType)!)
        let videoAsset = AVAsset(url: url!)
        return AVPlayerItem(asset: videoAsset)
    }
    
    
    
}
