//
//  SearchViewController.swift
//  FitHub
//
//  Created by cyrill on 2018/1/22.
//  Copyright © 2018年 cyrill.win. All rights reserved.
//

import UIKit

enum SearchType: String {
    case repositories
    case code
    case commits
    case issues
    case wikis
    case users
}

class SearchViewController: UITableViewController, UISearchBarDelegate, StoryboardLoadable {
    
    var nav: UINavigationController?
    
    var text: String = ""
    
    var type: SearchType!
    
    var users = [UserModel]()
    var repos = [RepositoryModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        type = SearchType.repositories
        
        tableView.register(UINib(nibName: "\(SearchSectionHeaderView.self)", bundle: nil), forHeaderFooterViewReuseIdentifier: "header")
        tableView.fit_registerCell(cell: UserTableViewCell.self)
        tableView.fit_registerCell(cell: RepositoriesTableViewCell.self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.users.removeAll()
        self.repos.removeAll()
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


// MARK: - UISearchBarDelegate

extension SearchViewController {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let text = searchBar.text
        
        if text == "" {
            self.users.removeAll()
            self.repos.removeAll()
            self.tableView.reloadData()
            return
        }
        
        if let _ = text {
            self.text = text!
            switch type {
            case .repositories?:
                self.searchRepos(name: text!)
            case .users?:
                self.searchUsers(name: text!)
            default:
                break
            }
        }
    }
}

extension SearchViewController {
    
    func searchRepos(name: String) {
        NetworkManager.searchRepos(name: name, success: { (items) in
            self.repos = items
            
            self.tableView.reloadData()
        }) { (_) in
            
        }
    }
    
    func searchUsers(name: String) {
        NetworkManager.searchUser(name: name, success: { (items) in
            self.users = items
            
            self.tableView.reloadData()
        }) { (_) in
            
        }
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}

extension SearchViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch type {
        case .repositories?:
            return repos.count
        case .users?:
            return users.count
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch type {
        case .repositories?:
            let cell = tableView.fit_dequeueReusableCell(indexPath: indexPath) as RepositoriesTableViewCell
            cell.model = self.repos[indexPath.row]
            return cell
        case .users?:
            let cell = tableView.fit_dequeueReusableCell(indexPath: indexPath) as UserTableViewCell
            cell.model = self.users[indexPath.row]
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! SearchSectionHeaderView
        header.type = type
        header.reposBlock = {
            self.repos.removeAll()
            self.type = .repositories
            self.tableView.reloadData()
            self.searchRepos(name: self.text)
        }
        
        header.usersBlock = {
            self.users.removeAll()
            self.type = .users
            self.tableView.reloadData()
            self.searchUsers(name: self.text)
        }
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch type {
        case .repositories?:
            return UITableViewAutomaticDimension
        case .users?:
            return 60
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch type {
        case .repositories?:
            let vc = RepositoryViewController.loadStoryboard()
            vc.userName = self.repos[indexPath.row].owner!.login!
            vc.repositoryName = self.repos[indexPath.row].name!
            self.nav?.pushViewController(vc, animated: true)
        case .users?:
            
            let model = self.users[indexPath.row]
            if model.type == "User" {
                let vc = UserDetailViewController.loadStoryboard()
                vc.name = model.login!
                self.nav?.pushViewController(vc, animated: true)
            } else {
                let vc = OrgViewController.loadStoryboard()
                vc.name = model.login!
                self.nav?.pushViewController(vc, animated: true)
            }
            
        default:
            break
        }
    }
}
