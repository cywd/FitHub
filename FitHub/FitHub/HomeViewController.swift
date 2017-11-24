//
//  HomeViewController.swift
//  FitHub
//
//  Created by Cyrill on 2017/11/21.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

import UIKit
import FitRefresh

class HomeViewController: BaseViewController {
    
    @IBOutlet weak var cityItem: UIBarButtonItem!
    @IBOutlet weak var languageItem: UIBarButtonItem!

    var page: Int = 1
    var scrollView: UIScrollView?
    var items = [UserModel]()
    
    var total_count: Int = 0 {
        didSet {
            let localStr = NSLocalizedString("HOME_TOTAL", comment: "总数描述");
            self.totalLabel.text = "\(localStr):\(total_count)"
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        
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
        
        var location = UserDefaults.standard.object(forKey: "location") as? String
        if location == nil {
            location = "beijing"
        }
        var language = UserDefaults.standard.object(forKey: "language") as? String
        if language == nil {
            language = ""
        }
        
        self.navigationItem.title = language
        if language == "" {
            self.navigationItem.title = NSLocalizedString("ALL_LANGUAGE", comment: "所有语言")
        }
        
        NetworkManager.loadUserDataWith(page: self.page, location: location!, language: language!) { (items, total_count) in
            self.tableView.fr.headerView?.endRefreshing()
            self.tableView.fr.footerView?.endRefreshing()

            if self.page == 1 {
                self.items = items
            } else {
                self.items = self.items + items
            }
            self.total_count = total_count
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
    
    @IBAction func cityItemTap(_ sender: UIBarButtonItem) {
        print("cityItemTap")
    }
    
    @IBAction func languageItemTap(_ sender: UIBarButtonItem) {
        print("languageItemTap")
        
        let vc = LanguageViewController.loadStoryboard()
        vc.backHandler = {
            self.tableView.fr.headerView?.beginRefreshing()
        }
        self.navigationController?.pushViewController(vc, animated: true)
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

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
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
        let vc = UserDetailViewController()
        vc.name = self.items[indexPath.row].login!
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
