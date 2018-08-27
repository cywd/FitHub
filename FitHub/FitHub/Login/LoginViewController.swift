//
//  LoginViewController.swift
//  FitHub
//
//  Created by Cyrill on 2017/11/28.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

import UIKit
import SafariServices

private let loginUrl = URL(string: "https://github.com/login/oauth/authorize?client_id=\("8d53a809cf0b28bb1ff7")&scope=user+repo+notifications")!
private let callbackURLScheme = "fithub://"

class LoginViewController: BaseViewController {

    enum State {
        case idle
        case logining
    }
    
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
        
//        if #available(iOS 11.0, *) {
//            self.authSession = SFAuthenticationSession(url: loginUrl, callbackURLScheme: callbackURLScheme, completionHandler: { [weak self] (callBackUrl, error) in
//                guard error == nil, let callBackUrl = callBackUrl else {
//                    switch error! {
//                    case SFAuthenticationError.canceledLogin: break
//                    default: print("error")
//                    }
//                    return
//                }
//                self?.receivedCodeRedirect(url: callBackUrl)
//            })
//            self.authSession?.start()
//        }
        
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
    
//    func receivedCodeRedirect(url: URL) {
//        guard let code = url.absoluteString.valueForQuery(key: "code") else { return }
//    }
    
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
