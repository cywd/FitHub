//
//  RepositoryTableViewCell.swift
//  FitHub
//
//  Created by Cyrill on 2017/11/23.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell, RegisterCellOrNib {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var starLabel: UILabel!
    @IBOutlet weak var desLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var forkLabel: UILabel!
    
    var model: RepositoryModel? {
        didSet {
            self.nameLabel.text = model!.full_name
            if let starCount = model?.stargazers_count {
                self.starLabel.text = "⭐️\(starCount)"
            }
            
            self.desLabel.text = model!.repositoryDescription
            
            if let fork = model?.forks_count {
                self.forkLabel.text = "📎\(fork)"
            }
            
            if let language = model?.language {
                self.languageLabel.isHidden = false
                self.languageLabel.text = "🌐\(language)"
            } else {
                self.languageLabel.isHidden = true
            }
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
