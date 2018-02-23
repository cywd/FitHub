//
//  ReposTableViewController.swift
//  FitHub
//
//  Created by cyrill on 2018/1/8.
//  Copyright © 2018年 cyrill.win. All rights reserved.
//

import UIKit
import FitRefresh

class ReposTableViewController: UITableViewController, StoryboardLoadable {
    
    var url: String? = ""
    var page: Int = 1
    var items = [RepositoryModel]()
    
    var hud: FitHud?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.fit_registerCell(cell: RepositoriesTableViewCell.self)
        
        self.tableView.fr.headerView = FRNormalHeader(ComponentRefreshingClosure: {
            self.loadData()
        })
        
//        self.tableView.fr.headerView?.beginRefreshing()
        self.hud = FitHud.show(view: self.view)
        self.loadData()
    }
    
    fileprivate func loadData() {
        self.page = 1
        self.requestData()
    }
    
    fileprivate func loadMore() {
        self.page += 1
        self.requestData()
    }
    
    fileprivate func requestData() {
        NetworkManager.loadCommonRepos(withUrl: self.url!, page: self.page, success: { (items) in
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
                self.tableView.fr.footerView = nil;
            } else {
                self.tableView.fr.footerView = FRAutoNormalFooter(ComponentRefreshingClosure: {
                    self.loadMore()
                })
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
        self.tableView.fr.footerView?.isHidden = (items.count == 0)
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.fit_dequeueReusableCell(indexPath: indexPath) as RepositoriesTableViewCell
        cell.model = items[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = RepositoryViewController.loadStoryboard()
        vc.userName = items[indexPath.row].owner!.login!
        vc.repositoryName = items[indexPath.row].name!
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)!
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.2) //设置动画时间
        cell.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        UIView.commitAnimations()
    }
    
    override func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)!
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.2) //设置动画时间
        cell.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        UIView.commitAnimations()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
