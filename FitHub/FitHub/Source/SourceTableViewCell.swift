//
//  SourceTableViewCell.swift
//  FitHub
//
//  Created by cyrill on 2018/1/9.
//  Copyright © 2018年 cyrill.win. All rights reserved.
//

import UIKit

class SourceTableViewCell: UITableViewCell, RegisterCellOrNib {

    @IBOutlet weak var typeImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var model: ContentModel? {
        didSet {
            let image = model!.isDirectory ? #imageLiteral(resourceName: "folder") : #imageLiteral(resourceName: "file")
            typeImageView.image = image
            nameLabel.text = model!.name
            
            self.accessoryType = model!.isDirectory ? UITableViewCellAccessoryType.disclosureIndicator : UITableViewCellAccessoryType.none
            
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
