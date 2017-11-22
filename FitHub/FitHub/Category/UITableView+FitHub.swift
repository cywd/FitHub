
//
//  UITableView+FitHub.swift
//  FitHub
//
//  Created by Cyrill on 2017/11/22.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

import UIKit

extension UITableView {
    
    /// 注册cell registerCell
    ///
    /// - Parameter cell: cell.self
    func fit_registerCell<T: UITableViewCell>(cell: T.Type) where T:  RegisterCellOrNib {
        if let xib = T.xib {
            register(xib, forCellReuseIdentifier: T.identifier)
        } else {
            register(cell, forCellReuseIdentifier: T.identifier)
        }
    }
    

    /// 复用cell dequeueReusableCell
    ///
    /// - Parameter indexPath: indexPath
    /// - Returns: cell
    func fit_dequeueReusableCell<T: UITableViewCell>(indexPath: IndexPath) -> T where T: RegisterCellOrNib {
        return dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as! T
    }
}
