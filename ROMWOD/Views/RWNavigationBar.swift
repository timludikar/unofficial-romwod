//
//  RWNavigationBar.swift
//  ROMWOD
//
//  Created by Tim Ludikar on 2018-09-04.
//  Copyright © 2018 Tim Ludikar. All rights reserved.
//

import UIKit

class RWNavigationBar: UINavigationBar {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setNavigation()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setNavigation()
    }
    
    private func setNavigation(){
        let backView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let logo = UIImage(named: "Logo")
        let imageView = UIImageView(image: logo)
        imageView.frame.size = CGSize(width: 30, height: 30)
        backView.addSubview(imageView)
        self.topItem?.titleView = backView
    }

}
