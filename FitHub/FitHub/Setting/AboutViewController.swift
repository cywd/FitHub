//
//  AboutViewController.swift
//  FitHub
//
//  Created by Cyrill on 2017/12/5.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

import UIKit

class AboutViewController: BaseViewController, StoryboardLoadable {
    
    
    @IBOutlet weak var arrowView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = #colorLiteral(red: 0.2666666667, green: 0.2666666667, blue: 0.2666666667, alpha: 1)
        self.arrowView.backgroundColor = #colorLiteral(red: 0.2666666667, green: 0.2666666667, blue: 0.2666666667, alpha: 1)
        
        let arrowDrawView = DownArrowView(frame: CGRect(x: 0, y: 0, width: 50, height: 10))
        arrowDrawView.backgroundColor = #colorLiteral(red: 0.2666666667, green: 0.2666666667, blue: 0.2666666667, alpha: 1)
        self.arrowView.addSubview(arrowDrawView)
        
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
