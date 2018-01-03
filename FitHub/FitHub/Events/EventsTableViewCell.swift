//
//  EventsTableViewCell.swift
//  FitHub
//
//  Created by Cyrill on 2017/12/4.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

import UIKit

class EventsTableViewCell: UITableViewCell, RegisterCellOrNib {

    var delegate: EventsTableViewCellDelegate?
    
    @IBOutlet weak var textView: UITextView!
    
    var model: EventModel? {
        didSet {
            let str = model!.finAttributeString
            self.textView.attributedText = str
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
    func repositoryTap(userName: String, repositoryName: String)
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
                let string = arr[1]
                let array = string.split(separator: "/")
                self.delegate?.repositoryTap(userName: String(array[0]), repositoryName: String(array[1]))
            }
        }
        
        return false
    }
    
}

extension EventsTableViewCell {
    
    func show() {
        UIView.animate(withDuration: 0.3) {
            self.textView.alpha = 1
        }
    }
    
    func hide() {
        self.textView.alpha = 0
    }
    
}
