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
    
    let DaysOfTheWeek = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    
    @IBInspectable
    var borderColour: UIColor? {
        didSet { layer.borderColor = borderColour?.cgColor }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        didSet { layer.borderWidth = borderWidth }
    }
    
    @IBInspectable
    var innerBorderWidth: CGFloat {
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
        self.borderWidth = CGFloat(0)
        self.innerBorderWidth = CGFloat(0)
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.borderWidth = CGFloat(0)
        self.innerBorderWidth = CGFloat(0)
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup(){
        let screenWidth = Int(self.frame.size.width/7)
        let calendarHeight = Int(self.frame.size.height)
        for (index, dayOfTheWeek) in DaysOfTheWeek.enumerated() {
            let day = UILabel(frame: CGRect(x: (index * screenWidth), y: 0, width: screenWidth, height: calendarHeight))
            day.text = dayOfTheWeek.prefix(3).uppercased()
            day.textAlignment = .center            
            self.addSubview(day)
        }
    }

}
