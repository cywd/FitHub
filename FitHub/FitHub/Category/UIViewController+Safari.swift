//
//  UIViewController+Safari.swift
//  FitHub
//
//  Created by cyrill on 2018/1/10.
//  Copyright © 2018年 cyrill.win. All rights reserved.
//

import UIKit
import SafariServices

extension UIViewController {
    
    func presentSafari(url: URL) {
        guard let safariVC = try? SFSafariViewController.configured(with: url) else {
            return
        }
        present(safariVC, animated: true)
    }
    
    func presentSafari(login: String) {
        present(CreateProfileViewController(login: login), animated: true)
    }
    
    func presentCommit(owner: String, repo: String, hash: String) {
        guard let url = URL(string: "https://github.com/\(owner)/\(repo)/commit/\(hash)") else { return }
        presentSafari(url: url)
    }
    
    func presentLabels(owner: String, repo: String, label: String) {
        guard let url = URL(string: "https://github.com/\(owner)/\(repo)/labels/\(label)") else { return }
        presentSafari(url: url)
    }
    
    func presentMilestone(owner: String, repo: String, milestone: Int) {
        guard let url = URL(string: "https://github.com/\(owner)/\(repo)/milestone/\(milestone)") else { return }
        presentSafari(url: url)
    }
    
    func CreateProfileViewController(login: String) -> UIViewController {
        let url = URL(string: "https://github.com/\(login)")!
        return try! SFSafariViewController.configured(with: url)
    }
}

extension SFSafariViewController {
    
    static func configured(with url: URL) throws -> SFSafariViewController {
        let http = "http"
        let schemedURL: URL
        // handles http and https
        if url.scheme?.hasPrefix(http) == true {
            schemedURL = url
        } else {
            guard let u = URL(string: http + "://" + url.absoluteString) else { throw URL.Error.failedToCreateURL }
            schemedURL = u
        }
        let safariVC = SFSafariViewController(url: schemedURL)
        safariVC.preferredBarTintColor = #colorLiteral(red: 0.2666666667, green: 0.2666666667, blue: 0.2666666667, alpha: 1)
        return safariVC
    }
}

extension URL {
    
    enum Error: Swift.Error {
        case failedToCreateURL
    }
}
