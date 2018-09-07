//
//  RWVideoThumbnail.swift
//  ROMWOD
//
//  Created by Tim Ludikar on 2018-09-05.
//  Copyright © 2018 Tim Ludikar. All rights reserved.
//

import UIKit

class RWVideoThumbnail: UIView {

    let nibName = "RWVideoThumbnail"
    private var contentView: UIView?
    
    @IBOutlet weak var dateHeader: UILabel!
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var videoTitle: UILabel!
    @IBOutlet weak var videoDescription: UITextView!
    @IBOutlet weak var videoDuration: UILabel!
    
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


