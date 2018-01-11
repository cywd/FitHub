//
//  RepositoryViewController.swift
//  FitHub
//
//  Created by cyrill on 2018/1/2.
//  Copyright © 2018年 cyrill.win. All rights reserved.
//

import UIKit

class RepositoryViewController: BaseViewController, StoryboardLoadable {
    
    var userName: String = ""
    var repositoryName: String = ""
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var forkView: UIView!
    @IBOutlet weak var forkButton: UIButton!
    @IBOutlet weak var watchLabel: UILabel!
    @IBOutlet weak var starLabel: UILabel!
    @IBOutlet weak var forkLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    
    @IBOutlet weak var licenseButton: UIButton!
    
    var model: RepositoryModel?
    
    var hud: FitHud?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.isHidden = true
        self.title = repositoryName
        
        self.requestUserData()
    }
    
    fileprivate func requestUserData() {
        self.hud = FitHud.show(view: self.view)
        NetworkManager.repositoryDetailWith(userName: userName, repositoryName: repositoryName, success: { (repositoryModel) in

            self.hud?.hide()
            
            self.model = repositoryModel
            
            if let name = self.model?.full_name {
                self.nameLabel.isHidden = false
                self.nameLabel.text = name
            } else {
                self.nameLabel.isHidden = true
            }
            
            if (self.model?.isFork)! {
                self.forkView.isHidden = false
                if let forkName = self.model?.parent?.full_name {
                    self.forkButton.setTitle(forkName, for: .normal)
                } else {
                    self.forkView.isHidden = true
                }
            } else {
                self.forkView.isHidden = true
            }
            
            self.watchLabel.text = "\(self.model?.subscribers_count ?? 0)\nWatch"
            self.starLabel.text = "\(self.model?.stargazers_count ?? 0)\nStar"
            self.forkLabel.text = "\(self.model?.forks_count ?? 0)\nFork"
            
            
            if let des = self.model?.repositoryDescription {
                self.bioLabel.text = des
            } else {
                self.bioLabel.text = ""
            }
            
            if let license = self.model?.license {
                self.licenseButton.isHidden = false
                self.licenseButton .setTitle(license.name, for: .normal)
            } else {
                self.licenseButton.isHidden = true
            }
            
            self.scrollView.isHidden = false
            
        }) { (error) in
            self.hud?.hide()
            print("请求失败")
        }
    }
    
    @IBAction func forkButtonTap(_ sender: Any) {
        let vc = RepositoryViewController.loadStoryboard()
        vc.userName = self.model!.parent!.owner!.login!
        vc.repositoryName = self.model!.name!
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func licenseButtonTap(_ sender: Any) {
        let vc = LicenseViewController.loadStoryboard()
        vc.url = self.model!.license!.url!
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func ownerButtonTap(_ sender: Any) {
        let vc = UserDetailViewController.loadStoryboard()
        vc.name = self.model!.owner!.login!
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func sourceButtonTap(_ sender: Any) {
        let vc = SourceTableViewController.loadStoryboard()
        vc.url = self.model!.url! + "/contents"
        vc.title = "Source"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func issuesButtonTap(_ sender: Any) {
        
    }
    
    @IBAction func readmeButtonTap(_ sender: Any) {
//        let vc = WebViewController.loadStoryboard()
//        vc.url = self.model!.html_url! + "/blob/master/README.md"
//        vc.title = "Readme"
//        self.navigationController?.pushViewController(vc, animated: true)
        
        let vc = ReadmeViewController()
        vc.url = self.model!.url! + "/readme"
        vc.title = "Readme"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func websiteButtonTap(_ sender: Any) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "watch" {
            let vc = segue.destination as! UsersTableViewController
            vc.url = self.model!.subscribers_url!
            vc.title = "Watch"
        } else if segue.identifier == "star" {
            let vc = segue.destination as! UsersTableViewController
            vc.url = self.model!.stargazers_url!
            vc.title = "Star"
        } else if segue.identifier == "fork" {
            let vc = segue.destination as! ReposTableViewController
            vc.url = self.model!.forks_url!
            vc.title = "Fork"
        } else {
            
        }
    }

}
