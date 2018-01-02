//
//  RepositoriesTableViewCell.swift
//  FitHub
//
//  Created by Cyrill on 2017/11/23.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

import UIKit

class RepositoriesTableViewCell: UITableViewCell, RegisterCellOrNib {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var desLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var forkButton: UIButton!
    @IBOutlet weak var typeImageView: UIImageView!
    
    var model: RepositoryModel? {
        didSet {
            self.nameLabel.text = model!.full_name
            if let starCount = model?.stargazers_count {
                self.starButton.setTitle("\(starCount)", for: .normal)
            }
            
            let isFork = model?.isFork
            self.typeImageView.image = isFork! ? #imageLiteral(resourceName: "fork") : #imageLiteral(resourceName: "repository")
            
            self.desLabel.text = model!.repositoryDescription
            
            if let fork = model?.forks_count {
                self.forkButton.setTitle("\(fork)", for: .normal)
            }
            
            if let language = model?.language {
                self.languageLabel.isHidden = false
                self.languageLabel.text = "\(language)"
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
