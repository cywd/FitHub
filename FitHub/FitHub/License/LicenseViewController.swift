//
//  LicenseViewController.swift
//  FitHub
//
//  Created by cyrill on 2018/1/9.
//  Copyright © 2018年 cyrill.win. All rights reserved.
//

import UIKit

class LicenseViewController: BaseViewController, StoryboardLoadable {

    var url: String? = ""
    var model: LicenseModel?
    @IBOutlet weak var textView: UITextView!
    var hud: FitHud?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        requestData()
    }
    
    func requestData() {
        self.hud = FitHud.show(view: self.view)
        
        NetworkManager.loadLicenseData(withUrl: self.url!, success: { (model) in
            
            self.hud?.hide()
            
            self.model = model
            self.textView.text = self.model?.body
            self.title = self.model?.name
            
        }) { (error) in
            self.hud?.hide()
            print("请求失败")
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
