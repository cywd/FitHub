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
    
    var model: RepositoryModel?
    
    var hud: FitHud?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.isHidden = true
        
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
            
            self.watchLabel.text = "\(self.model?.watchers_count ?? 0)\nWatch"
            self.starLabel.text = "\(self.model?.stargazers_count ?? 0)\nStar"
            self.forkLabel.text = "\(self.model?.forks_count ?? 0)\nFork"
            
            
            if let des = self.model?.repositoryDescription {
                self.bioLabel.text = des
            } else {
                self.bioLabel.text = ""
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
