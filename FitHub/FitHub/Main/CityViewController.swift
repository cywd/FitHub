//
//  CityViewController.swift
//  FitHub
//
//  Created by Cyrill on 2017/11/30.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

import UIKit

class CityViewController: BaseViewController {

    var selectString: String?
    var backHandler: (()->())?
    
    var items: [String] {
        get {
            
            return Locations.locations()
            
//            return ["China",
//                    "Beijing", "Shanghai", "Shenzhen",
//                    "Hangzhou", "Guangzhou", "Chengdu",
//                    "Nanjing", "Wuhan", "Xiamen",
//                    "Tianjin", "Chongqing", "Changsha", "Shenyang"]
        }
    }
    
    // MARK: -
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 44;
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        let locationStr = NSLocalizedString("LOCATION", comment: "地理位置")
        self.title = locationStr
        
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "locationCell")
        if let loccation = selectString {
            let index = items.firstIndex(of: loccation)
            let indexPath = IndexPath(row: index!, section: 0)
            tableView.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.top, animated: true)
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

extension CityViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let string = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell")
        cell?.textLabel?.text = string
        
        if string == self.selectString {
            cell?.textLabel?.textColor = UIColor.red
        } else {
            cell?.textLabel?.textColor = nil
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        var str = ""
        if indexPath.row != 0 {
            str = items[indexPath.row]
        }
        UserDefaults.standard.set(str, forKey: "location")
        self.backHandler?()
        self.navigationController?.popViewController(animated: true)
    }
    
}
