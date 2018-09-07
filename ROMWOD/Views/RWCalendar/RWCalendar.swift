//
//  RWCalendar.swift
//  ROMWOD
//
//  Created by Tim Ludikar on 2018-09-04.
//  Copyright © 2018 Tim Ludikar. All rights reserved.
//

import UIKit

@IBDesignable
class RWCalendar: UIView {
    
    let DaysOfTheWeek = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    var delegate: RWCalendarEventDelegate?
    
    @IBInspectable
    var borderColour: UIColor? {
        didSet { layer.borderColor = borderColour?.cgColor }
    }
    
    @IBInspectable
    var borderWidth: CGFloat = CGFloat(0) {
        didSet { layer.borderWidth = borderWidth }
    }
    
    @IBInspectable
    var innerBorderWidth: CGFloat = CGFloat(0) {
        didSet {
            self.subviews.forEach { (view) in
                view.layer.borderWidth = innerBorderWidth
            }
        }
    }
    
    @IBInspectable
    var innerBorderColor: UIColor? {
        didSet {
            self.subviews.forEach { (view) in
                view.layer.borderColor = innerBorderColor?.cgColor
            }
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
    
    private func setup(){
        let screenWidth = Int(self.frame.size.width)/Int(DaysOfTheWeek.count)
        let calendarHeight = Int(self.frame.size.height)
        for (index, dayOfTheWeek) in DaysOfTheWeek.enumerated() {
            let day = UIButton(frame: CGRect(x: (index * screenWidth), y: 0, width: screenWidth, height: calendarHeight))
            day.addTarget(self, action: #selector(self.tapFunction(_:)), for: UIControlEvents.allTouchEvents)
            let title = dayOfTheWeek.prefix(3).uppercased()
            day.titleLabel?.font = UIFont(name: "Oswald-Medium", size: 12)
            day.setTitleColor(UIColor.black, for: .normal)
            day.setTitle(title, for: UIControlState.normal)
            day.tag = index
            self.addSubview(day)
        }
        
        setNeedsLayout()
        setNeedsDisplay()
    }
    
    @objc
    func tapFunction(_ sender: UIButton){
        delegate?.calendarEvent(self, didSelectItemAt: sender.tag)
    }
}
