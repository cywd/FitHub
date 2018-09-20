//
//  UIViewController+Alert.swift
//  FitHub
//
//  Created by cyrill on 2018/1/12.
//  Copyright © 2018年 cyrill.win. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController.configured(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "好的", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    func showMessage(message: String, after: TimeInterval = 1) {
        let vc = UIAlertController.configured(
            message: message,
            preferredStyle: .alert)
        present(vc, animated: true) {
            DispatchQueue.main.after(after, execute: {
                vc.dismiss(animated: true, completion: nil)
            })
        }
    }
}

extension UIViewController {
    
    static func configured(title: String? = nil, message: String? = nil, preferredStyle: UIAlertController.Style) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        alertController.view.tintColor = #colorLiteral(red: 0.2666666667, green: 0.2666666667, blue: 0.2666666667, alpha: 1)
        return alertController
    }
}
