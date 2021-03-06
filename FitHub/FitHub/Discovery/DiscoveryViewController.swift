//
//  DiscoveryViewController.swift
//  FitHub
//
//  Created by cyrill on 2018/1/18.
//  Copyright © 2018年 cyrill.win. All rights reserved.
//

import UIKit

class DiscoveryViewController: BaseViewController, UISearchControllerDelegate, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {

    var items = [RepositoryModel]()
    
    @IBOutlet weak var tableView: UITableView!
    var searchController: UISearchController!
    var searchResultController: SearchViewController!
    
    var hud: FitHud?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.fit_registerCell(cell: RepositoriesTableViewCell.self)
        
        searchResultController = SearchViewController.loadStoryboard()
        searchResultController.nav = self.navigationController
        
        searchController = UISearchController(searchResultsController: searchResultController)
        searchController.searchResultsUpdater = searchResultController
        searchController.delegate = self
        searchController.searchBar.delegate = searchResultController
        searchController.searchBar.sizeToFit()
        searchController.searchBar.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        definesPresentationContext = true
        
        self.hud = FitHud.show(view: self.view)
        self.requestData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        self.animateTable()
    }
    
    func animateTable() {
        let cells = self.tableView.visibleCells
        let tableHeight = self.tableView.bounds.size.height
        for (index, cell) in cells.enumerated() {
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
            UIView.animate(withDuration: 1.0, delay: 0.05 * Double(index), usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: [], animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: nil)
        }
    }

    fileprivate func requestData() {
        NetworkManager.getTrendingRepository(success: { (items) in
            
            self.hud?.hide()
            
            self.items = items
            
            self.tableView.reloadData()
            self.animateTable()
            
        }) { (_) in
            self.hud?.hide()
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


// MARK: - UITableViewDatasource

extension DiscoveryViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.fit_dequeueReusableCell(indexPath: indexPath) as RepositoriesTableViewCell
        cell.model = items[indexPath.row]
        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension DiscoveryViewController {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = RepositoryViewController.loadStoryboard()
        vc.userName = self.items[indexPath.row].owner!.login!
        vc.repositoryName = self.items[indexPath.row].name!
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)!
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.2) //设置动画时间
        cell.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        UIView.commitAnimations()
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)!
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.2) //设置动画时间
        cell.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        UIView.commitAnimations()
    }
    
}

// MARK: - UISearchControllerDelegate

extension DiscoveryViewController {
    func presentSearchController(_ searchController: UISearchController) {
        //debugPrint("UISearchControllerDelegate invoked method: \(__FUNCTION__).")
    }
    
    func willPresentSearchController(_ searchController: UISearchController) {
        //debugPrint("UISearchControllerDelegate invoked method: \(__FUNCTION__).")
    }
    
    func didPresentSearchController(_ searchController: UISearchController) {
        //debugPrint("UISearchControllerDelegate invoked method: \(__FUNCTION__).")
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        //debugPrint("UISearchControllerDelegate invoked method: \(__FUNCTION__).")
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        //debugPrint("UISearchControllerDelegate invoked method: \(__FUNCTION__).")
    }
    
}
