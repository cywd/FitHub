//
//  UsersTableViewController.swift
//  FitHub
//
//  Created by cyrill on 2018/1/8.
//  Copyright © 2018年 cyrill.win. All rights reserved.
//

import UIKit
import FitRefresh

class UsersTableViewController: UITableViewController, StoryboardLoadable {

    var url: String? = ""
    
    var page: Int = 1
    var items = [UserModel]()
    var hud: FitHud?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.tableView.fit_registerCell(cell: UserTableViewCell.self)
        self.page = 1
        self.tableView.fr.headerView = FRNormalHeader(ComponentRefreshingClosure: {
            self.loadData()
        })
//        self.tableView.fr.headerView?.beginRefreshing()
        
        self.hud = FitHud.show(view: self.view)
        self.loadData()
        
        self.tableView.fr.footerView = FRAutoNormalFooter(ComponentRefreshingClosure: {
            self.loadMore()
        })
    }
    
    func loadData() {
        self.page = 1
        self.requestData()
    }
    
    func loadMore() {
        self.page += 1
        self.requestData()
    }
    
    func requestData() {
        
        NetworkManager.loadCommonUsers(withUrl: self.url!, page: self.page, success: { (items) in
            self.hud?.hide()
            self.tableView.fr.headerView?.endRefreshing()
            self.tableView.fr.footerView?.endRefreshing()
            
            if self.page == 1 {
                self.items = items
            } else {
                self.items += items
            }
            self.tableView.reloadData()
            
            if items.count < 30 {
                self.tableView.fr.footerView?.isHidden = true
            } else {
                self.tableView.fr.footerView?.isHidden = false
            }
        }) { (error) in
            self.hud?.hide()
            self.tableView.fr.headerView?.endRefreshing()
            self.tableView.fr.footerView?.endRefreshing()
            if self.page > 1 {
                self.page -= 1
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.tableView.fr.footerView?.isHidden = (items.count < 30)
        return self.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.fit_dequeueReusableCell(indexPath: indexPath) as UserTableViewCell
        cell.model = self.items[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = UserDetailViewController.loadStoryboard()
        vc.name = self.items[indexPath.row].login!
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
