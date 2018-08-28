//
//  VideoThumbnail.swift
//  ROMWOD
//
//  Created by Tim Ludikar on 2018-08-13.
//  Copyright © 2018 Tim Ludikar. All rights reserved.
//

import UIKit

class VideoThumbnail: UICollectionViewCell {
    var videoThumbnail: UIVideoThumbnail? {
        didSet {
            self.addSubview(videoThumbnail!)
        }
    }
}
