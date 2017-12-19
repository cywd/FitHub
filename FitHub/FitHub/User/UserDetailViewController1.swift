//
//  UserDetailViewController.swift
//  FitHub
//
//  Created by Cyrill on 2017/11/23.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

import UIKit
import FitRefresh

class UserDetailViewController1: BaseViewController {
    
    var page: Int = 1
    
    var headerView: UserDetailHeaderView!
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
//        tableView.rowHeight = 120.0
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        return tableView
    }()
    
    var items = [RepositoryModel]()
    var name: String = ""
    var model: UserModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.addSubview(self.tableView)
        self.tableView.frame = self.view.bounds
        
        self.tableView.fr.headerView = FRNormalHeader(ComponentRefreshingClosure: {
            self.loadData()
        })

        requestUserData()
    }
    
    fileprivate func loadData() {
        self.page = 1
        self.requestData()
    }
    
    fileprivate func loadMore() {
        self.page += 1
        self.requestData()
    }
    
    fileprivate func requestUserData() {
        NetworkManager.loadUserDetailDataWith(userName: name, success: { (userModel) in
            self.model = userModel
            
            self.headerView = UserDetailHeaderView.defaultView()
            self.tableView.tableHeaderView = self.headerView
            self.refreshHeader()
            self.tableView.fit_registerCell(cell: RepositoryTableViewCell.self)
            
            self.requestData()
            
        }) { (error) in
            print("请求失败")
        }
    }
    
    fileprivate func requestData() {
        NetworkManager.loadUserRepositoriesDataWith(page: self.page, userName: name, success: { (items) in
            self.tableView.fr.headerView?.endRefreshing()
            self.tableView.fr.footerView?.endRefreshing()
            
            if self.page == 1 {
                self.items = items
            } else {
                self.items = self.items + items
            }
            
            self.tableView.reloadData()
            
            if items.count == 0 {
                self.tableView.fr.footerView = nil;
            } else {
                self.tableView.fr.footerView = FRAutoNormalFooter(ComponentRefreshingClosure: {
                    self.loadMore()
                })
            }
        }) { (error) in
            self.tableView.fr.headerView?.endRefreshing()
            self.tableView.fr.footerView?.endRefreshing()
            if self.page > 1 {
                self.page -= 1
            }
        }

    }

    fileprivate func refreshHeader() {
        headerView.model = self.model
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

extension UserDetailViewController1: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.tableView.fr.footerView?.isHidden = (items.count == 0)
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.fit_dequeueReusableCell(indexPath: indexPath) as RepositoryTableViewCell
        cell.model = items[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}
