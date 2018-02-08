//
//  MeViewController.swift
//  FitHub
//
//  Created by Cyrill on 2017/11/21.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

import UIKit

class MeViewController: BaseViewController {

    // MARK: - lifecycle
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
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 44;
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        return tableView
    }()
    
    @objc func rightTap() {
        NetworkManager.logout()
        self.tableView.reloadData()
    }
    
    // MARK: - dealloc
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
            name = NSLocalizedString("LOGIN", comment: "登录")
        case 1:
            let aboutStr = NSLocalizedString("ABOUT", comment: "关于")
            name = aboutStr
        default:
            name = ""
        }
        
        if NetworkManager.isLogin() {
            if indexPath.row == 0 {
                if let model = UserSessionManager.myself {
                    name = model.login!
                }
            }
            
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: NSLocalizedString("LOGOUT", comment: "退出"), style: .plain, target: self, action: #selector(rightTap))
            self.navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 1, green: 0.231372549, blue: 0.1882352941, alpha: 1)
        } else {
            self.navigationItem.rightBarButtonItem = nil
        }
        
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "MeTableViewCell")
        
        cell.textLabel?.text = name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            if NetworkManager.isLogin() {
                if let model = UserSessionManager.myself {
                    let vc = UserDetailViewController.loadStoryboard()
                    vc.name = model.login!
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            } else {
                let loginVC = LoginViewController()
                self.navigationController?.present(loginVC, animated: true, completion: {
                    
                })
            }
        } else if indexPath.row == 1 {
            let vc = AboutViewController.loadStoryboard()
            self.tabBarController?.present(vc, animated: true, completion: nil)
        }
    }
    
}
