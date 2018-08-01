//
//  UIVideoThumbnail.swift
//  ROMWOD
//
//  Created by Tim Ludikar on 2018-07-31.
//  Copyright © 2018 Tim Ludikar. All rights reserved.
//

import UIKit

@IBDesignable class UIVideoThumbnail: UIView {
    
    @IBInspectable @IBOutlet weak var title: UILabel!
    @IBInspectable @IBOutlet weak var date: UILabel!
    @IBInspectable @IBOutlet weak var desc: UILabel!
    @IBInspectable @IBOutlet weak var thumbnail: UIImageView!
    
    let nibName = "UIVideoThumbnail"
    var contentView : UIView!
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        xibSetup()
    }
    
    func xibSetup() {
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        view.autoresizingMask =
            [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        contentView = view
    }
    
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(
            withOwner: self,
            options: nil).first as? UIView
    }
    
    override open func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        xibSetup()
        contentView?.prepareForInterfaceBuilder()
    }
}
