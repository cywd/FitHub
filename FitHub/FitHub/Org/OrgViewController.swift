//
//  OrgViewController.swift
//  FitHub
//
//  Created by cyrill on 2018/1/17.
//  Copyright © 2018年 cyrill.win. All rights reserved.
//

import UIKit

class OrgViewController: BaseViewController, StoryboardLoadable {

    var name: String = ""
    var model: OrgModel?
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var headImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    
    @IBOutlet weak var repositoriesLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    
    @IBOutlet weak var companyButton: UIButton!
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var blogButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var membersButton: UIButton!

    var hud: FitHud?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = name
        //        self.orgButton.setTitle(NSLocalizedString("ORGS", comment: "组织"), for: .normal)
        
        membersButton.setTitle(NSLocalizedString("MEMBERS", comment: "MEMBERS"), for: .normal)
        
        self.requestUserData()
    }
    
    // 大标题还不完善
    //    override func viewWillAppear(_ animated: Bool) {
    //        super.viewWillAppear(animated)
    //        self.navigationController?.navigationBar.prefersLargeTitles = true
    //    }
    //
    //    override func viewWillDisappear(_ animated: Bool) {
    //        super.viewWillDisappear(animated)
    //        self.navigationController?.navigationBar.prefersLargeTitles = false
    //    }
    
    fileprivate func requestUserData() {
        self.hud = FitHud.show(view: self.view)
        NetworkManager.loadOrgDataWith(orgName: name, success: { (orgModel) in
            
            self.hud?.hide()
            
            self.model = orgModel
        
            self.typeLabel.text = NSLocalizedString("ORG", comment: "org")
            self.headerView.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0.5018981074)
            
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
            
            if let des = self.model?.desc {
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
    
    @IBAction func blogTap(_ sender: Any) {
        let vc = WebViewController.loadStoryboard()
        vc.url = self.model!.blog
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func staredTap(_ sender: Any) {
//        let vc = ReposTableViewController.loadStoryboard()
//        vc.url = self.model!.url! + "/starred"
//        vc.title = "Stared"
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "followers" {
            
        } else if segue.identifier == "repositories" {
            let vc = segue.destination as! ReposTableViewController
            vc.url = self.model!.repos_url
            vc.title = "Repositories"
        } else if segue.identifier == "following" {
            
        } else if segue.identifier == "member" {
            let vc = segue.destination as! UsersTableViewController
            vc.url = self.model!.url! + "/members"
            vc.title = "Members"
        }
    }

}
