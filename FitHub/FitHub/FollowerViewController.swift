//
//  FollowerViewController.swift
//  FitHub
//
//  Created by Cyrill on 2017/11/28.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

import UIKit
import FitRefresh

class FollowerViewController: BaseViewController {
    
    var name: String = ""
    
    var page: Int = 1
    var scrollView: UIScrollView?
    var items = [UserModel]()
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.tableView.fit_registerCell(cell: UserTableViewCell.self)
        self.page = 1
        self.tableView.fr.headerView = FRNormalHeader(ComponentRefreshingClosure: {
            self.loadData()
        })
        self.tableView.fr.headerView?.beginRefreshing()
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
    
        NetworkManager.loadUserFollowersDataWith(page: self.page, userName: name) { (items) in
            self.tableView.fr.headerView?.endRefreshing()
            self.tableView.fr.footerView?.endRefreshing()
            
            if self.page == 1 {
                self.items = items
            } else {
                self.items = self.items + items
            }
            self.tableView.reloadData()
            
            if items.count == 0 {
                self.tableView.fr.footerView?.isHidden = true
            } else {
                self.tableView.fr.footerView?.isHidden = false
            }
        }
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

extension FollowerViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.tableView.fr.footerView?.isHidden = (items.count == 0)
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.fit_dequeueReusableCell(indexPath: indexPath) as UserTableViewCell
        cell.model = self.items[indexPath.row]
        cell.indexPath = indexPath
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = UserDetailViewController.loadStoryboard()
        vc.name = self.items[indexPath.row].login!
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
