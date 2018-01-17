//
//  OrgsTableViewCell.swift
//  FitHub
//
//  Created by cyrill on 2018/1/17.
//  Copyright © 2018年 cyrill.win. All rights reserved.
//

import UIKit
import Kingfisher

class OrgsTableViewCell: UITableViewCell, RegisterCellOrNib {
    
    @IBOutlet weak var headImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var model: OrgModel? {
        didSet {
            
            if let headImageUrl = model!.avatar_url {
                headImageView.kf.setImage(with: URL(string: headImageUrl))
            }
            
            if let nameString = model!.login {
                nameLabel.text = nameString
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

