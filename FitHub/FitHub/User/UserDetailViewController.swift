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

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var headImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!

    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var repositoriesLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!

    @IBOutlet weak var companyButton: UIButton!
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var blogButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var orgButton: UIButton!
    
    var hud: FitHud?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.title = name
        self.requestUserData()
    }

    fileprivate func requestUserData() {
        self.hud = FitHud.show(view: self.view)
        NetworkManager.loadUserDetailDataWith(userName: name, success: { (userModel) in
            
            self.hud?.hide()
            
            self.model = userModel
            
            switch self.model?.type {
                
            case "Organization"?:
                self.typeLabel.text = NSLocalizedString("ORG", comment: "org")
                self.headerView.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0.5018981074)
                self.orgButton.isHidden = true
                break
            case "User"?:
                self.typeLabel.text = NSLocalizedString("USER", comment: "user")
                self.headerView.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 0.5)
                self.orgButton.isHidden = false
                break
            default:
                break
            }
            
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
            
            self.repositoriesLabel.text = "\(self.model?.public_repos ?? 0)\nRepositories"
            self.followersLabel.text = "\(self.model?.followers ?? 0)\nFollowers"
            self.followingLabel.text = "\(self.model?.following ?? 0)\nFollowing"
            
            if let company = self.model?.company {
                self.companyButton.isHidden = company==""
                self.companyButton.setTitle(company, for: UIControlState.normal)
            } else {
                self.companyButton.isHidden = true
            }
            if let location = self.model!.location {
                self.locationButton.isHidden = location==""
                self.locationButton.setTitle(location, for: UIControlState.normal)
            } else {
                self.locationButton.isHidden = true
            }
            if let email = self.model!.email {
                self.emailButton.isHidden = email==""
                self.emailButton.setTitle(email, for: UIControlState.normal)
            } else {
                self.emailButton.isHidden = true
            }
            if let blog = self.model!.blog {
                self.blogButton.isHidden = blog==""
                self.blogButton.setTitle(blog, for: UIControlState.normal)
            } else {
                self.blogButton.isHidden = true
            }
            if let time = self.model!.created_at {
                self.timeLabel.isHidden = false
                let subString = time.prefix(10)
                self.timeLabel.text = "on " + String(subString)
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
        }) { (error) in
            self.hud?.hide()
            print("请求失败")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "followers" {
            let vc = segue.destination as! FollowerViewController
            vc.name = self.name
        } else if segue.identifier == "repositories" {
            let vc = segue.destination as! RepositoriesViewController
            vc.name = self.name
        } else if segue.identifier == "following" {
            let vc = segue.destination as! FollowingViewController
            vc.name = self.name
        } else if segue.identifier == "org" {
            let vc = segue.destination as! OrgsViewController
            vc.url = self.model!.organizations_url!
        }
    }

}
