//
//  WebViewController.swift
//  FitHub
//
//  Created by cyrill on 2018/1/9.
//  Copyright © 2018年 cyrill.win. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: BaseViewController, StoryboardLoadable {

    var url: String? = ""
    @IBOutlet weak var webView: WKWebView!
    var hud: FitHud?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let request = URLRequest(url: URL(string: url!)!)
        webView.load(request)
        webView.navigationDelegate = self
        
        self.hud = FitHud.show(view: self.view)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension WebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.hud?.hide()
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        self.hud?.hide()
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.hud?.hide()
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}
