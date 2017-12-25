//
//  LaunchViewController.swift
//  FitHub
//
//  Created by cyrill on 2017/12/18.
//  Copyright © 2017年 cyrill.win. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController, StoryboardLoadable {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var fitLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        UIView.animate(withDuration: 2, delay: 0, options: UIViewAnimationOptions.allowAnimatedContent, animations: {
            self.logoImageView.alpha = 0
            self.fitLabel.alpha = 0
            
        }) { (complete) in
            
//            self.logoImageView.isHidden = true
//        
//            self.fitLabel.alpha = 1
//            self.fitLabel.text = "Wecome"
            
            self.changeVC()
        
        }
    }
    
    private func changeVC() {
        let mainStory = UIStoryboard(name: "Main", bundle: nil)
        let vc = mainStory.instantiateInitialViewController()
        UIApplication.shared.keyWindow?.rootViewController = vc
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
