//
//  AboutViewController.swift
//  FitHub
//
//  Created by Cyrill on 2017/12/5.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

import UIKit

class AboutViewController: BaseViewController, StoryboardLoadable {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var arrowView: DownArrowView!
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = NSLocalizedString("ABOUT_DESC", comment: "APP desc")
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

extension AboutViewController: UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y == -scrollView.adjustedContentInset.top {
            self.arrowView.lineAnimation()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y == -scrollView.adjustedContentInset.top {
            self.arrowView.arrowAnimation()
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        let offset = scrollView.contentOffset
        if offset.y < -100 {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}
