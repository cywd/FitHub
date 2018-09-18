//
//  AppDelegate.swift
//  FitHub
//
//  Created by Cyrill on 2017/11/17.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

import UIKit
import AlamofireNetworkActivityIndicator

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        NetworkActivityIndicatorManager.shared.isEnabled = true

        // 调试的私有API 不知道为什么不好使了
//        let overlayClass = NSClassFromString("UIDebuggingInformationOverlay") as? UIWindow.Type
//        _ = overlayClass?.perform(NSSelectorFromString("prepareDebuggingOverlay"))

        self.initShortItems()
        
        return true
    }
    
    func getTheLaunchImage() -> UIImage? {
        
        let viewSize = UIScreen.main.bounds.size;

        var viewOrientation: String?
        if ((UIApplication.shared.statusBarOrientation == UIInterfaceOrientation.portraitUpsideDown) || (UIApplication.shared.statusBarOrientation == UIInterfaceOrientation.portrait)) {
            viewOrientation = "Portrait";
        } else {
            viewOrientation = "Landscape";
        }
        
        var launchImage: String! = ""

        let imagesDict = Bundle.main.infoDictionary!["UILaunchImages"] as! [Any]

        for dic in imagesDict {

            let dict = dic as! [String : Any]

            let imageSize = NSCoder.cgSize(for: dict["UILaunchImageSize"] as! String)

            if (imageSize.equalTo(viewSize) && (viewOrientation == dict["UILaunchImageOrientation"] as? String))
            {
                launchImage = (dict["UILaunchImageName"] as! String)
            }
        }
        return UIImage(named: launchImage)
    }
    
    private func initShortItems() {
        
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
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        
        if shortcutItem.type == "com.cy.events" {
            
            if self.window!.rootViewController!.isKind(of: UITabBarController.self) {
                let tabbarVC = self.window!.rootViewController as! TabBarController
                tabbarVC.selectedIndex = 1
            }
            
        } else if shortcutItem.type == "com.cy.me" {
            if self.window!.rootViewController!.isKind(of: UITabBarController.self) {
                let tabbarVC = self.window!.rootViewController as! TabBarController
                tabbarVC.selectedIndex = 3
                
                let nav = tabbarVC.viewControllers!.last as! NavigationController
                let vc = nav.viewControllers.first as! MeViewController
                vc.tableView(vc.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
            }
        } else if shortcutItem.type == "com.cy.discovery" {
            if self.window!.rootViewController!.isKind(of: UITabBarController.self) {
                let tabbarVC = self.window!.rootViewController as! TabBarController
                tabbarVC.selectedIndex = 2
            }
        }
    }

}
