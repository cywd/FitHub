//
//  DarkLogoView.swift
//  FitHub
//
//  Created by Cyrill on 2017/12/6.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

import UIKit

class DarkLogoView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        Logo.drawDarkLogo(frame: rect)
    }
    
}
