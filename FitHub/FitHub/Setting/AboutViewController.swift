//
//  AboutViewController.swift
//  FitHub
//
//  Created by Cyrill on 2017/12/5.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

import UIKit

class AboutViewController: BaseViewController, StoryboardLoadable {
    
    
    @IBOutlet weak var arrowView: DownArrowView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
        
    @IBAction func pan(_ sender: UIPanGestureRecognizer) {
        self.commitTranslation(sender.translation(in: self.view))
    }
   
    func commitTranslation(_ translation: CGPoint) {
    
        let absX: CGFloat = fabs(translation.x)
        let absY: CGFloat = fabs(translation.y)
        
        // 设置滑动有效距离
        if max(absX, absY) < 10 { return };

        if (absX > absY) {
            if (translation.x < 0) {
                // 向左滑动
            } else {
                // 向右滑动
            }
        } else if (absY > absX) {
            if (translation.y < 0) {
                // 向上滑动
            } else {
                // 向下滑动
//                print(translation.y)
//                self.modalPresentationStyle = UIModalPresentationStyle.formSheet
//                self.view.y = translation.y
//                if translation.y > 200 {
//
//                } else {
//
//                    self.view.y = 0
//                }
                
                self.dismiss(animated: true, completion: nil)
            }
        }
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
