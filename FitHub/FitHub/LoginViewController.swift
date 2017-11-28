//
//  LoginViewController.swift
//  FitHub
//
//  Created by Cyrill on 2017/11/28.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {

    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var pwdTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func loginTap(_ sender: UIButton) {
        
        let name = self.nameTextField.text!
        let pwd = self.pwdTextField.text!
        
        NetworkManager.login(name: name, pwd: pwd) {
            self.dismiss(animated: true, completion: nil)
        }
    }
   
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
