//
//  UIVideoThumbnail.swift
//  ROMWOD
//
//  Created by Tim Ludikar on 2018-07-31.
//  Copyright © 2018 Tim Ludikar. All rights reserved.
//

import UIKit

@IBDesignable class UIVideoThumbnail: UIView {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var descriptionTab: UIView!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var drawConstraint: NSLayoutConstraint!
    
    var drawState: displayState = .CLOSED
    
    var performActionOnDrawer: (_ action: @escaping () -> Void, _ completion: @escaping (Bool) -> Void) -> Void = { (action, completion) in
        UIView.animate(withDuration: 0.4, animations: action, completion: completion)
    }
    
    enum displayState {
        case OPEN
        case CLOSED
    }
    
    @IBAction func tapOn(_ sender: UITapGestureRecognizer) {
        switch drawState {
        case .OPEN:
            closeDrawer()
        case .CLOSED:
            openDrawer()
        }
    }
    
    let nibName = "UIVideoThumbnail"
    
    convenience init(draw state: displayState){
        self.init(frame: CGRect.zero)
        if(state == .CLOSED){
            self.closeDrawer()
        } else {
            self.openDrawer()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        xibSetup()
    }
    
    func openDrawer() {
        performActionOnDrawer({
            self.descriptionTab.frame.origin.y -= self.drawConstraint.constant
        }, { _ in
            self.drawState = .OPEN
        })
    }
    
    func closeDrawer() {
        performActionOnDrawer({
            self.descriptionTab.frame.origin.y += self.drawConstraint.constant
        }, { _ in
            self.drawState = .CLOSED
        })
    }
    
    func xibSetup() {
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        view.autoresizingMask =
            [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        contentView = view
    }
    
    func setImage(to image: Data){
        self.thumbnail.image = UIImage(data: image)
    }
    
    func setDate(to date: Date){
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "EEEE, MMMM d, YYYY"
        let displayFormat = dateFormat.string(from: date)
        self.date.text = "\(displayFormat)"
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
