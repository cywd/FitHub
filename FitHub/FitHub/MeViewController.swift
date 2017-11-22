//
//  MeViewController.swift
//  FitHub
//
//  Created by Cyrill on 2017/11/21.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

import UIKit

class MeViewController: BaseViewController {

    // MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.view.addSubview(self.tableView)
        self.tableView.frame = self.view.bounds
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MeTableViewCell")
    }
    
    // MARK: -
    
    // MARK: -
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 44;
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        return tableView
    }()
    
    // MARK: -
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension MeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var name: String = ""
        switch indexPath.row {
        case 0:
            name = "login"
        case 1:
            name = "about"
        default:
            name = ""
        }
        
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "MeTableViewCell")
        
        cell.textLabel?.text = name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
