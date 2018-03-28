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
    private lazy var progressView: UIProgressView = {
        let progressView = UIProgressView(frame: CGRect(x: 0, y: 44.5, width: UIScreen.main.bounds.size.width, height: 2.0))
        progressView.tintColor = #colorLiteral(red: 0.1690405011, green: 0.6988298297, blue: 0.3400650322, alpha: 1)
        progressView.tintAdjustmentMode = .normal
        progressView.progress = 0.0
        progressView.trackTintColor = UIColor.clear
        return progressView
    }()
    var hud: FitHud?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.addSubview(self.progressView)
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: NSKeyValueObservingOptions.new, context: nil)
        
        let request = URLRequest(url: URL(string: url!)!)
        webView.load(request)
        webView.navigationDelegate = self
        webView.uiDelegate = self
        
        self.hud = FitHud.show(view: self.view)
        
        setupBackButton()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    func setupBackButton() {
        let backItem = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.plain, target: self, action: #selector(goBack))
        if self.webView.canGoBack {
            let closeItem = UIBarButtonItem(title: "关闭", style: UIBarButtonItemStyle.plain, target: self, action: #selector(closeWebView))
            self.navigationItem.leftBarButtonItems = [backItem, closeItem]
        } else {
            self.navigationItem.leftBarButtonItems = [backItem]
        }
        
    }
    
    @objc func goBack() {
        if self.webView.canGoBack {
            self.webView.goBack()
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func closeWebView() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            if let progress = change?[NSKeyValueChangeKey.newKey] as? Float {
                self.progressView.setProgress(progress, animated: true)
                
                if progress == 1.0 {
                    DispatchQueue.main.after(0.5, execute: {
                        self.progressView.isHidden = true
                        self.progressView.progress = 0.0
                    })
                } else {
                    self.progressView.isHidden = false
                }
            }
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        webView.removeObserver(self, forKeyPath: "estimatedProgress")
        self.webView.scrollView.delegate = nil;
        self.webView.navigationDelegate = nil;
        self.webView.uiDelegate = nil;
        self.webView = nil;
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
        
        webView.evaluateJavaScript("var a = document.getElementsByTagName('a');for(var i=0;i<a.length;i++){a[i].setAttribute('target','');}", completionHandler: nil)
        
        setupBackButton()
        
        webView.evaluateJavaScript("document.title") { (obj, error) in
            self.navigationItem.title = obj as? String
        }
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

extension WebViewController: WKUIDelegate {
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if let frameInfo = navigationAction.targetFrame {
            if !frameInfo.isMainFrame {
                webView.load(navigationAction.request)
            }
        }
        return webView
    }
}
