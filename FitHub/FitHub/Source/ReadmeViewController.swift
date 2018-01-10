//
//  ReadmeViewController.swift
//  FitHub
//
//  Created by cyrill on 2018/1/10.
//  Copyright © 2018年 cyrill.win. All rights reserved.
//

import UIKit
import MarkdownView
import SnapKit

class ReadmeViewController: BaseViewController {

    var url: String? = ""
    var model: ContentModel?
    var md: MarkdownView!
    var hud: FitHud?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        md = MarkdownView()
        self.view.addSubview(md)
        
        md.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        requestData()
    }
    
    func requestData() {
        
        self.hud = FitHud.show(view: self.view)
        
        NetworkManager.loadContentData(withUrl: url!, success: { (contentModel) in
            
            self.hud?.hide()
            
            self.model = contentModel
            if let content = self.model?.content {
                let data = Data(base64Encoded: content, options: [.ignoreUnknownCharacters])!
                let text = String(data: data, encoding: .utf8)
                
                self.md.load(markdown: text)
            }
            
        }) { (error) in
            self.hud?.hide()
            print(error)
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
