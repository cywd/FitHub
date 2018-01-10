//
//  ReadmeViewController.swift
//  FitHub
//
//  Created by cyrill on 2018/1/10.
//  Copyright © 2018年 cyrill.win. All rights reserved.
//

import UIKit

class ReadmeViewController: BaseViewController {

    var url: String? = ""
    var model: ContentModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        requestData()
    }
    
    func requestData() {
        NetworkManager.loadContentData(withUrl: url!, success: { (model) in
            self.model = model
            
            if let content = self.model?.content {
                let data = Data(base64Encoded: content, options: [.ignoreUnknownCharacters])
                let text = String(data: data!, encoding: .utf8)
                
                
            }
            
        }) { (error) in
            print(error)
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
