//
//  UIVideoThumbnail.swift
//  ROMWOD
//
//  Created by Tim Ludikar on 2018-07-31.
//  Copyright © 2018 Tim Ludikar. All rights reserved.
//

import UIKit

class UIVideoThumbnail: UIView {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var date: RMDateLabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var descriptionTab: UIView!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var drawConstraint: NSLayoutConstraint!
    
    
    var performActionOnDrawer: (_ action: @escaping () -> Void, _ completion: @escaping (Bool) -> Void) -> Void = { (action, completion) in
        UIView.animate(withDuration: 0.4, animations: action, completion: completion)
    }
    
    var isClosed: Bool = false {
        didSet {
            if(isClosed){
                self.openDrawer()
            } else {
                self.closeDrawer()
            }
        }
    }

    let nibName = "UIVideoThumbnail"
    
    convenience init(frame: CGRect, workout item: ScheduledWorkouts) {
        self.init(frame: frame)
        self.title.text = item.name
        self.desc.text = item.description
        self.date.date = item.date
        self.date.isHidden = item.isHidden
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
    
    func xibSetup() {
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        view.autoresizingMask =
            [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        contentView = view
    }

    private func openDrawer() {
        performActionOnDrawer({
            self.descriptionTab.frame.origin.y -= self.drawConstraint.constant
        }, { _ in
        })
    }

    private func closeDrawer() {
        performActionOnDrawer({
            self.descriptionTab.frame.origin.y += self.drawConstraint.constant
        }, { _ in
        })
    }
    
    func showDate(){
        date.alpha = 0
        date.isHidden = false
        let animator = UIViewPropertyAnimator(duration: 1, curve: .easeInOut)
        animator.addAnimations {
            self.date.alpha = 1
        }
        
        animator.startAnimation()
    }
    
    func hideDate(){

        let animator = UIViewPropertyAnimator(duration: 1, curve: .easeInOut)
        animator.addCompletion { (_) in
            self.date.alpha = 0
            self.date.isHidden = true
        }
        animator.addAnimations {
            self.date.alpha = 0
        }
        
        animator.startAnimation()
        

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

class RMDateLabel: UILabel {
    var date: Date? {
        didSet {
            let dateFormat = DateFormatter()
            guard let date = date else { return }
            dateFormat.dateFormat = "EEEE, MMMM d, YYYY"
            self.text = dateFormat.string(from: date)
        }
    }
}

