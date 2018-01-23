//
//  SearchSectionHeaderView.swift
//  FitHub
//
//  Created by cyrill on 2018/1/23.
//  Copyright © 2018年 cyrill.win. All rights reserved.
//

import UIKit

class SearchSectionHeaderView: UITableViewHeaderFooterView {
    
    var reposBlock: (()->())?
    var usersBlock: (()->())?
    
    @IBOutlet weak var reposButton: UIButton!
    @IBOutlet weak var usersButton: UIButton!
    
    var type: SearchType! {
        
        didSet {
            switch type {
            case .repositories:
                reposState()
            case .users:
                usersState()
            default:
                break
            }
        }
    }
    
    @IBAction func reposTap(_ sender: Any) {
//        self.type = .repositories
        if let reposBlock = self.reposBlock {
            reposBlock()
        }
    }
    
    @IBAction func usersTap(_ sender: Any) {
//        self.type = .users
        if let usersBlock = self.usersBlock {
            usersBlock()
        }
    }
    
    func reposState() {
        usersButton.isSelected = false
        reposButton.isSelected = true
    }
    
    func usersState() {
        usersButton.isSelected = true
        reposButton.isSelected = false
    }
    
}
