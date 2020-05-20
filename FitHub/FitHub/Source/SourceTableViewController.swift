//
//  SourceTableViewController.swift
//  FitHub
//
//  Created by cyrill on 2018/1/9.
//  Copyright © 2018年 cyrill.win. All rights reserved.
//

import UIKit
import FitRefresh

class SourceTableViewController: UITableViewController, StoryboardLoadable {

    var page: Int = 1
    var url: String? = ""
    var hud: FitHud?
    var items = [ContentModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.fit_registerCell(cell: SourceTableViewCell.self)
        self.tableView.estimatedRowHeight = UIScreen.main.bounds.height;
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
        NetworkManager.loadContentsData(withUrl: self.url!, success: { (items) in
            self.hud?.hide()
            self.tableView.fr.headerView?.endRefreshing()
            self.tableView.fr.footerView?.endRefreshing()
            
            if self.page == 1 {
                self.items = items
            } else {
                self.items += items
            }
            
            self.tableView.reloadData()
            
//            if items.count < 30 {
//                self.tableView.fr.footerView = nil;
//            } else {
//                self.tableView.fr.footerView = FRAutoNormalFooter(ComponentRefreshingClosure: {
//                    self.loadMore()
//                })
//            }
            
        }) { (error) in
            self.hud?.hide()
            self.tableView.fr.headerView?.endRefreshing()
            self.tableView.fr.footerView?.endRefreshing()
            
            if self.page > 1 {
                self.page -= 1
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.fit_dequeueReusableCell(indexPath: indexPath) as SourceTableViewCell
        cell.model = self.items[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = self.items[indexPath.row]
        
        if model.isDirectory {
            let vc = SourceTableViewController.loadStoryboard()
            vc.title = model.name
            vc.url = model.url!
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = WebViewController.loadStoryboard()
            vc.title = model.name
            vc.url = model.html_url!
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
