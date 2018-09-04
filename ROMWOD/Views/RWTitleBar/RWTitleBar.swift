//
//  RWTitleBar.swift
//  ROMWOD
//
//  Created by Tim Ludikar on 2018-09-04.
//  Copyright © 2018 Tim Ludikar. All rights reserved.
//

import UIKit

@IBDesignable class RWTitleBar: UIView {
    
    let nibName = "RWTitleBar"
    var contentView: UIView?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: RWDateRange!
    
//    @IBInspectable var text: String? {
//        didSet { titleLabel.text = text }
//    }
//
//    @IBInspectable var date: String? {
//        didSet { dateLabel.text = date }
//    }
//
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
    
//    override func prepareForInterfaceBuilder() {
//        super.prepareForInterfaceBuilder()
//        titleLabel.text = "Schedule for:"
//        dateLabel.text = "September 3 - September 9, 2018"
//        self.backgroundColor = UIColor.black
//    }
}

class RWDateRange: UILabel {
    func setRange(startDate: Date, endDate: Date) -> Void {
        self.text = "\(formatStartDate(startDate)) - \(formatEndDate(endDate))"
    }
    
    private func formatStartDate(_ startDate: Date) -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "MMMM d"
        return dateFormat.string(from: startDate)
    }
    
    private func formatEndDate(_ endDate: Date) -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "MMMM d, YYYY"
        return dateFormat.string(from: endDate)
    }
}
