//
//  LanguageViewController.swift
//  FitHub
//
//  Created by Cyrill on 2017/11/24.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

import UIKit

class LanguageViewController: BaseViewController, StoryboardLoadable {
    
    @IBOutlet weak var tableView: UITableView!

    var selectString: String?
    var backHandler: (()->())?

    var items: [String] {
        get {
            let allLanguageStr = NSLocalizedString("ALL_LANGUAGE", comment: "所有语言")
            var arr = Languages.languages()
            arr.insert(allLanguageStr, at: 0)
            return arr
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let allLanguageStr = NSLocalizedString("CODE_LANGUAGE", comment: "编程语言")
        self.title = allLanguageStr
        
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "locationCell")
        
        if let language = selectString {
            let index = items.firstIndex(of: language)
            let indexPath = IndexPath(row: index!, section: 0)
            tableView.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.top, animated: true)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension LanguageViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let string = items[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "languageCell")
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
        UserDefaults.standard.set(str, forKey: "language")
        self.backHandler!()
        self.navigationController?.popViewController(animated: true)
    }
    
}
