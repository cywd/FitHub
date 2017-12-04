//
//  EventsViewController.swift
//  FitHub
//
//  Created by Cyrill on 2017/11/29.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

import UIKit

class EventsViewController: BaseViewController {
    var name =  UserDefaults.standard.value(forKey: "username") as? String ?? ""
    
    var items = [EventModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        NetworkManager.getRepositoriesEventsWith(page: 1, username: name) { (items) in
            
            self.items = items
            
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
