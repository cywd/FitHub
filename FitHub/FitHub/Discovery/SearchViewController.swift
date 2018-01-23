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
            return
        }
        
        self.text = text!
        
        switch type {
        case .repositories:
            self.searchRepos(name: text!)
        case .users:
            self.searchUsers(name: text!)
        default:
            break
        }
    }
}

extension SearchViewController {
    
    func searchRepos(name: String) {
        NetworkManager.searchUser(name: name, success: { (items) in
            self.users = items
            
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
        case .repositories:
            return repos.count
        case .users:
            return users.count
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch type {
        case .repositories:
            let cell = tableView.fit_dequeueReusableCell(indexPath: indexPath) as RepositoriesTableViewCell
            cell.model = self.repos[indexPath.row]
            return cell
        case .users:
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
            self.searchRepos(name: self.text)
            self.type = .repositories
        }
        
        header.usersBlock = {
            self.searchUsers(name: self.text)
            self.type = .users
        }
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch type {
        case .repositories:
            return UITableViewAutomaticDimension
        case .users:
            return 60
        default:
            return 0
        }
    }
}
