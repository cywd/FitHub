//
//  UserDetailViewController.swift
//  FitHub
//
//  Created by Cyrill on 2017/11/23.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

import UIKit

class UserDetailViewController: BaseViewController {
    
    var headerView: UserDetailHeaderView!
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 60.0
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
        
        requestUserData()
        
    }
    
    fileprivate func loadData() {
        
    }
    
    fileprivate func loadMore() {
        
    }
    
    fileprivate func requestUserData() {
        NetworkManager.loadUserDetailDataWith(userName: name, completionHandler: { (userModel) in
            self.model = userModel
            
            self.headerView = UserDetailHeaderView.defaultView()
            self.tableView.tableHeaderView = self.headerView
            self.refreshHeader()
        })
    }
    
    fileprivate func requestData() {
        
        NetworkManager.loadUserRepositoriesDataWith(1, name) { (items) in
            self.items = items
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

extension UserDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}
