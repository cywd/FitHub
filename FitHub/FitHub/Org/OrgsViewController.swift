//
//  OrgsViewController.swift
//  FitHub
//
//  Created by cyrill on 2018/1/5.
//  Copyright © 2018年 cyrill.win. All rights reserved.
//

import UIKit
import FitRefresh

class OrgsViewController: BaseViewController, StoryboardLoadable {

    var url: String = ""
    
    var page: Int = 1
    var scrollView: UIScrollView?
    var items = [OrgModel]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.tableView.fit_registerCell(cell: OrgsTableViewCell.self)
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
        
        NetworkManager.loadOrgs(withUrl: url, page: self.page, success: { (items) in
            
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
            self.tableView.fr.headerView?.endRefreshing()
            self.tableView.fr.footerView?.endRefreshing()
            if self.page > 1 {
                self.page -= 1
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

extension OrgsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.tableView.fr.footerView?.isHidden = (items.count < 30)
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.fit_dequeueReusableCell(indexPath: indexPath) as OrgsTableViewCell
        cell.model = self.items[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = OrgViewController.loadStoryboard()
        vc.name = self.items[indexPath.row].login!
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

