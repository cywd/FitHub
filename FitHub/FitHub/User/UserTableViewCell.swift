//
//  UserTableViewCell.swift
//  FitHub
//
//  Created by Cyrill on 2017/11/22.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

import UIKit
import Kingfisher

class UserTableViewCell: UITableViewCell, RegisterCellOrNib {

    @IBOutlet weak var headImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var model: UserModel? {
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
