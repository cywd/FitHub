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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
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
            name = "Login"
        case 1:
            name = "About"
        default:
            name = ""
        }
        
        if NetworkManager.isLogin() {
            if indexPath.row == 0 {
                name = UserDefaults.standard.value(forKey: "username") as! String
            }
        }
        
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "MeTableViewCell")
        
        cell.textLabel?.text = name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            if NetworkManager.isLogin() {
                let vc = UserDetailViewController.loadStoryboard()
                vc.name = UserDefaults.standard.value(forKey: "username") as! String
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                let vc11 = LoginViewController()
                self.navigationController?.present(vc11, animated: true, completion: {
                    
                })
            }
        }
    }
}