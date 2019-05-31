//
//  LoginViewController.swift
//  FitHub
//
//  Created by Cyrill on 2017/11/28.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

import UIKit
import SafariServices
import Alamofire
import SwiftyJSON

private let loginUrl = URL(string: "https://github.com/login/oauth/authorize?client_id=\("8d53a809cf0b28bb1ff7")&scope=user+repo+notifications+gist")!
private let callbackURLScheme = "fithub://"

class LoginViewController: BaseViewController {

    enum State {
        case idle
        case logining
    }
    
    @IBOutlet weak var coverView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var pwdTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    private var authSession: SFAuthenticationSession? {
        get {
            return _authSession as? SFAuthenticationSession
        }
        set {
            _authSession = newValue
        }
    }
    
    private var _authSession: Any?
    
    var state: State = .idle {
        didSet {
            let hideSpinner: Bool
            switch state {
            case .idle: hideSpinner = true
            case .logining: hideSpinner = false
            }
            loginButton.isEnabled = hideSpinner
            activityIndicator.isHidden = hideSpinner
            
            let title = hideSpinner
                ? NSLocalizedString("登录", comment: "")
                : NSLocalizedString("登录中...", comment: "")
            loginButton.setTitle(title, for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        state = .idle

        self.nameTextField.placeholder = NSLocalizedString("USERNAME", comment: "用户名")
        self.pwdTextField.placeholder = NSLocalizedString("PASSWORD", comment: "密码")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func loginTap(_ sender: UIButton) {
        
        self.view.endEditing(true)
        
        let name = self.nameTextField.text!
        let pwd = self.pwdTextField.text!
        
        
        if name == "" {
            let desc = "您没有输入名字"
            self.showMessage(message: desc)
            return
        }
        if pwd == "" {
            let desc = "您没有输入密码"
            self.showMessage(message: desc)
            return
        }
        
        self.state = .logining
        
        NetworkManager.login(name: name, pwd: pwd, success: {
            
            var shortcutItems = [UIApplicationShortcutItem]()
            
            let discoveryIcon =  UIApplicationShortcutIcon(templateImageName: "discovery")
            let discoveryItem = UIApplicationShortcutItem(type: "com.cy.discovery", localizedTitle: "Discovery", localizedSubtitle: "", icon: discoveryIcon, userInfo: nil)
            shortcutItems.append(discoveryItem)
            
            if NetworkManager.isLogin() {
                let eventsIcon =  UIApplicationShortcutIcon(templateImageName: "events")
                let eventsItem = UIApplicationShortcutItem(type: "com.cy.events", localizedTitle: "Events", localizedSubtitle: "", icon: eventsIcon, userInfo: nil)
                shortcutItems.append(eventsItem)
                
                if let model = UserSessionManager.myself {
                    let meIcon =  UIApplicationShortcutIcon(templateImageName: "user")
                    let meItem = UIApplicationShortcutItem(type: "com.cy.me", localizedTitle: "Me", localizedSubtitle: model.login!, icon: meIcon, userInfo: nil)
                    shortcutItems.append(meItem)
                }
            } else {
                // 去登陆
            }
            
            UIApplication.shared.shortcutItems = shortcutItems
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LoginNotifation"), object: nil)
            
            self.dismiss(animated: true, completion: nil)
        }) { (statusCode, error) in
            
            self.state = .idle
            
            if statusCode == 401 {
                let desc = "用户名或密码错误"
                self.showMessage(message: desc)
            } else {
                let desc = "登录失败"
                self.showMessage(message: desc)
            }
        }
    }
    
    @IBAction func githubLoginTap(_ sender: UIButton) {
        self.view.endEditing(true)
        self.oneKeyLogin()
    }
    
    private func receivedCodeRedirect(url: URL) {
        
        guard let code = url.absoluteString.valueForQuery(key: "code") else { return }
        
        coverView.isHidden = false
        
        let url = "https://github.com/login/oauth/access_token"
        let dic = [
            "client_id" : "8d53a809cf0b28bb1ff7",
            "client_secret" : "ac0fbe152c8940c2bb1a71a80a849d1f5eba9aed",
            "code" : code
            ] as [String : Any]
        
        
        Alamofire.request(url, method: .post, parameters: dic, encoding: JSONEncoding.default, headers: nil).responseData { (response) in
            
            if let data = response.result.value, let utf8Text = String(data: data, encoding: .utf8) {
                
                
                if let urlParameters : [String: AnyObject] = utf8Text.onlyParameters {
                    
                    let token = urlParameters["access_token"]
                    print(token ?? "")
                    
                    var headers : [String : String]? { return ["Authorization": "token \(token!)"] }
                    
                    
                    UserDefaults.standard.set(headers, forKey: "header")
                    
                    
                    
                    Alamofire.request("https://api.github.com/user", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
                        
                        switch response.result {
                        case .success(let value):
                            let json = JSON(value)
                            
                            if let dataDict = json.dictionaryObject {
                                let model = UserModel(dict: dataDict as [String : AnyObject])
                                UserSessionManager.save(user: model)
                            }
                            
                            UserDefaults.standard.set(true, forKey: "isLogin")
                            var shortcutItems = [UIApplicationShortcutItem]()
                            
                            let discoveryIcon =  UIApplicationShortcutIcon(templateImageName: "discovery")
                            let discoveryItem = UIApplicationShortcutItem(type: "com.cy.discovery", localizedTitle: "Discovery", localizedSubtitle: "", icon: discoveryIcon, userInfo: nil)
                            shortcutItems.append(discoveryItem)
                            
                            if NetworkManager.isLogin() {
                                let eventsIcon =  UIApplicationShortcutIcon(templateImageName: "events")
                                let eventsItem = UIApplicationShortcutItem(type: "com.cy.events", localizedTitle: "Events", localizedSubtitle: "", icon: eventsIcon, userInfo: nil)
                                shortcutItems.append(eventsItem)
                                
                                if let model = UserSessionManager.myself {
                                    let meIcon =  UIApplicationShortcutIcon(templateImageName: "user")
                                    let meItem = UIApplicationShortcutItem(type: "com.cy.me", localizedTitle: "Me", localizedSubtitle: model.login!, icon: meIcon, userInfo: nil)
                                    shortcutItems.append(meItem)
                                }
                            } else {
                                // 去登陆
                            }
                            
                            self.coverView.isHidden = true
                            
                            UIApplication.shared.shortcutItems = shortcutItems
                            
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LoginNotifation"), object: nil)
                            
                            self.dismiss(animated: true, completion: nil)
                        case .failure(let error):
                            self.state = .idle
                            self.coverView.isHidden = true
                            
                            self.showMessage(message: error.localizedDescription)
                        }
                        
                    })
                    
                    
//                    UserDefaults.standard.set(true, forKey: "isLogin")
//
//                    UserSessionManager.save(token: token)
//
//                    self.loadUserDetailDataWith(userName: name, success: { (userModel) in
//                        UserSessionManager.save(user: userModel)
//                        success()
//                    }, failure: { (err) in
//                        failure(0, err)
//                    })
//
                }

                
            }
            
            
        }
    }
    
    private func oneKeyLogin() {
        if #available(iOS 11.0, *) {
            self.authSession = SFAuthenticationSession(url: loginUrl, callbackURLScheme: callbackURLScheme, completionHandler: { [weak self] (callBackUrl, error) in
                guard error == nil, let callBackUrl = callBackUrl else {
                    switch error! {
                    case SFAuthenticationError.canceledLogin: break
                    default: self?.handleError()
                    }
                    return
                }
                self?.receivedCodeRedirect(url: callBackUrl)
            })
            self.authSession?.start()
        }
    }
    
    private func handleError() {
        let alert = UIAlertController.configured(
            title: NSLocalizedString("Error", comment: ""),
            message: NSLocalizedString("There was an error signing in to GitHub. Please try again.", comment: ""),
            preferredStyle: .alert
        )
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    @IBAction func back(_ sender: Any) {
        
        self.view.endEditing(true)
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
