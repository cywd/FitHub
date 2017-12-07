//
//  RepositoryViewController.swift
//  FitHub
//
//  Created by Cyrill on 2017/11/28.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

import UIKit
import FitRefresh

class RepositoryViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!

    var page: Int = 1
    var items = [RepositoryModel]()
    var name: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.fit_registerCell(cell: RepositoryTableViewCell.self)

        self.tableView.fr.headerView = FRNormalHeader(ComponentRefreshingClosure: {
            self.loadData()
        })

        self.tableView.fr.headerView?.beginRefreshing()
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

        NetworkManager.loadUserRepositoriesDataWith(page: self.page, userName: name) { (items) in

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

extension RepositoryViewController: UITableViewDataSource, UITableViewDelegate {

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
