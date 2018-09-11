//
//  AVPlayer.swift
//  ROMWOD
//
//  Created by Tim Ludikar on 2018-09-11.
//  Copyright © 2018 Tim Ludikar. All rights reserved.
//

import AVFoundation

extension AVPlayer {
    var isPlaying: Bool {
        return rate != 0 && error == nil
    }
}

