//
//  UserDetailViewController.swift
//  FitHub
//
//  Created by Cyrill on 2017/11/27.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

import UIKit
import Kingfisher

class UserDetailViewController: BaseViewController, StoryboardLoadable {

    var name: String = ""
    var model: UserModel?
    
    @IBOutlet weak var headImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var loginLabel: UILabel!
    
    @IBOutlet weak var bioLabel: UILabel!
    
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var repositoryLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var blogLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.requestUserData()
    }

    fileprivate func requestUserData() {
        NetworkManager.loadUserDetailDataWith(userName: name, completionHandler: { (userModel) in
            self.model = userModel
            
            if let name = self.model?.name {
                self.nameLabel.isHidden = false
                self.nameLabel.text = name
            } else {
                self.nameLabel.isHidden = true
            }
            if let login = self.model?.login {
                self.loginLabel.isHidden = false
                self.loginLabel.text = login
            } else {
                self.loginLabel.isHidden = true
            }
            
            self.followersLabel.text = "\(self.model?.followers ?? 0)\nFollowers"
            self.repositoryLabel.text = "\(self.model?.public_repos ?? 0)\nRepository"
            self.followingLabel.text = "\(self.model?.following ?? 0)\nFollowing"
            
            if let company = self.model?.company {
                self.companyLabel.isHidden = false
                self.companyLabel.text = "🏢 "+company
            } else {
                self.companyLabel.isHidden = true
            }
            if let location = self.model!.location {
                self.locationLabel.isHidden = false
                self.locationLabel.text = "🏠 "+location
            } else {
                self.locationLabel.isHidden = true
            }
            if let email = self.model!.email {
                self.emailLabel.isHidden = false
                self.emailLabel.text = "📧 "+email
            } else {
                self.emailLabel.isHidden = true
            }
            if let blog = self.model!.blog {
                self.blogLabel.isHidden = false
                self.blogLabel.text = "🔗 "+blog
            } else {
                self.blogLabel.isHidden = true
            }
            if let time = self.model!.created_at {
                self.timeLabel.isHidden = false
                let subString = time.prefix(10)
                self.timeLabel.text = "⏳ "+String(subString)
            } else {
                self.timeLabel.isHidden = true
            }
            
            if let des = self.model?.bio {
                self.bioLabel.text = des
            } else {
                self.bioLabel.text = ""
            }
            
            if let imageName = self.model?.avatar_url {
                self.headImageView.kf.setImage(with: URL(string: imageName))
            }
            
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
