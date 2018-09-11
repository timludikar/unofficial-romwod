//
//  RWVideoThumbnail.swift
//  ROMWOD
//
//  Created by Tim Ludikar on 2018-09-05.
//  Copyright © 2018 Tim Ludikar. All rights reserved.
//

import UIKit

protocol RWVideoThumbnailDelegate {
    func video(_ video: RWVideoThumbnail, didSelectPlayButton index: Bool )
}

@IBDesignable
class RWVideoThumbnail: UIView {

    let nibName = "RWVideoThumbnail"
    private var contentView: UIView?
    
    var delegate: RWVideoThumbnailDelegate? {
        didSet {
            let gesture = UITapGestureRecognizer(target: self, action: #selector(self.imageTapGesture(_:)))
            videoThumbnail.addGestureRecognizer(gesture)
        }
    }
    
    var isVideoPlayback = false {
        didSet{
//            if(isVideoPlayback){
                videoThumbnail.isHidden = isVideoPlayback
//            } else {
//                videoThumbnail.isHidden =
//            }
        }
    }
    
    @IBOutlet weak var videoThumbnail: UIView!
    @IBOutlet weak var dateHeader: UILabel!
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var videoTitle: UILabel!
    @IBOutlet weak var videoDuration: RWPaddingLabel!
    @IBOutlet weak var videoDescription: UITextView!
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup(){
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        self.addSubview(view)
        contentView = view
        videoDescription.textContainerInset = UIEdgeInsets.zero
        videoDescription.textContainer.lineFragmentPadding = 0
    }
    
    @objc private func imageTapGesture(_ sender: UITapGestureRecognizer){
        delegate?.video(self, didSelectPlayButton: true)
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(
            withOwner: self,
            options: nil).first as? UIView
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }

}


