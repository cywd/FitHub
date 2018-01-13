//
//  UserSessionManager.swift
//  FitHub
//
//  Created by cyrill on 2018/1/12.
//  Copyright © 2018年 cyrill.win. All rights reserved.
//

import Foundation

class UserSessionManager: NSObject {
    
    static var token: String? {
        get {
            return UserDefaults.standard.object(forKey: "token") as? String 
        }
    }
    static var myself: UserModel? {
        get {
            if let data = UserDefaults.standard.object(forKey: "user") as? NSData {
                let user = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as! UserModel
                return user
            } else {
                return nil
            }
        }
    }
    
    class func save(user: UserModel) {
        let data = NSKeyedArchiver.archivedData(withRootObject: user)
        UserDefaults.standard.setValue(data, forKey: "user")
    }
    
    class func removeUser() {
        UserDefaults.standard.removeObject(forKey: "user")
    }
    
    class func removeToken() {
        UserDefaults.standard.removeObject(forKey: "token")
    }
    
    class func save(token: String?) {
        UserDefaults.standard.set(token, forKey: "token")
    }
}
