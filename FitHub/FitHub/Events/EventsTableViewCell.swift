//
//  EventsTableViewCell.swift
//  FitHub
//
//  Created by Cyrill on 2017/12/4.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

import UIKit

class EventsTableViewCell: UITableViewCell, RegisterCellOrNib {

//    @IBOutlet weak var label: UILabel!

    var delegate: EventsTableViewCellDelegate?
    
    @IBOutlet weak var label: UITextView!
    
    var model: EventModel? {
        didSet {
//            let str = model!.finDesc ?? " "
            
            let str = model!.finAttributeString
            
            self.label.attributedText = str
            
//            let strData = str.data(using: String.Encoding.unicode, allowLossyConversion: true)!
//            // FIXME: fix code
//            if let attrStr = try? NSAttributedString(data: strData, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
////                self.label.text = str
//                self.label.attributedText = str
//            }
            
//            do {
//                DispatchQueue.global().async {
//                    let strData = str.data(using: String.Encoding.unicode, allowLossyConversion: true)!
//
//                    if let attrStr = try? NSAttributedString(data: strData, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
//
//                        DispatchQueue.main.async {
//                            self.label.text = str
//                            self.label.attributedText = attrStr
//                        }
//                    }
//                }
//            } catch _ {
//
//            }
            
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

protocol EventsTableViewCellDelegate {
    func userTap(name: String)
    func repositoryTap(name: String)
}

extension EventsTableViewCell: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {

        let str = URL.absoluteString
        if str.hasPrefix("fithub-name://") {
            let arr: [String] = str.components(separatedBy: "fithub-name://")
            if arr.count > 1 {
                let name = arr[1]
                
                self.delegate?.userTap(name: name)
            }
            
        } else if str.hasPrefix("fithub-repo://") {
            let arr: [String] = str.components(separatedBy: "fithub-repo://")
            if arr.count > 1 {
                let name = arr[1]
                self.delegate?.repositoryTap(name: name)
            }
        }
        
        
        
        return false
    }
    
}
