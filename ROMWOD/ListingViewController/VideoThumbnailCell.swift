//
//  VideoThumbnail.swift
//  ROMWOD
//
//  Created by Tim Ludikar on 2018-08-13.
//  Copyright © 2018 Tim Ludikar. All rights reserved.
//

import UIKit

class VideoThumbnail: UICollectionViewCell {
    @IBOutlet weak var videoThumbnail: UIVideoThumbnail!
    
    func displayContent(title: String, date: Date, description: String, thumbnail: Data){
        videoThumbnail.title.text = title
        videoThumbnail.desc.text = description
    }
}
