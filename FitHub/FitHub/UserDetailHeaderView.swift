//
//  UserDetailHeaderView.swift
//  FitHub
//
//  Created by Cyrill on 2017/11/23.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

import UIKit
import Kingfisher

class UserDetailHeaderView: UIView {

    @IBAction func cityItem(_ sender: UIBarButtonItem) {
    }
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var realNameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var blogLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var desLabel: UILabel!
    
    var model: UserModel? {
        didSet {
            if let name = model!.name {
                self.nameLabel.isHidden = false
                self.nameLabel.text = name
            } else {
                self.nameLabel.isHidden = true
            }
            if let login = model!.login {
                self.realNameLabel.isHidden = false
                self.realNameLabel.text = login
            } else {
                self.realNameLabel.isHidden = true
            }
            if let company = model!.company {
                self.companyLabel.isHidden = false
                self.companyLabel.text = "🏢 "+company
            } else {
                self.companyLabel.isHidden = true
            }
            if let location = model!.location {
                self.locationLabel.isHidden = false
                self.locationLabel.text = "🏠 "+location
            } else {
                self.locationLabel.isHidden = true
            }
            if let email = model!.email {
                self.emailLabel.isHidden = email==""
                self.emailLabel.text = "📧 "+email
            } else {
                self.emailLabel.isHidden = true
            }
            if let blog = model!.blog {
                self.blogLabel.isHidden = blog==""
                self.blogLabel.text = "🔗 "+blog
            } else {
                self.blogLabel.isHidden = true
            }
            if let time = model!.created_at {
                self.timeLabel.isHidden = false
                let subString = time.prefix(10)
                self.timeLabel.text = "⏳ "+String(subString)
            } else {
                self.timeLabel.isHidden = true
            }
            
            if let des = model!.bio {
                self.desLabel.text = des
            } 
            
            if let imageName = model!.avatar_url {
                self.headerImageView.kf.setImage(with: URL(string: imageName))
            }
        }
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    class func defaultView() -> UserDetailHeaderView {
        return Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)?.last as! UserDetailHeaderView
    }

}
