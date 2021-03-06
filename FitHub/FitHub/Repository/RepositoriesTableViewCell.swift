//
//  RepositoriesTableViewCell.swift
//  FitHub
//
//  Created by Cyrill on 2017/11/23.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

import UIKit

class RepositoriesTableViewCell: UITableViewCell, RegisterCellOrNib {

    @IBOutlet weak var languageColorView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var desLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var forkButton: UIButton!
    @IBOutlet weak var licenseButton: UIButton!
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
                self.forkButton.isHidden = fork == 0
                self.forkButton.setTitle("\(fork)", for: .normal)
            }
            
            if let license = model?.license?.spdx_id {
                self.licenseButton.isHidden = false
                self.licenseButton.setTitle("\(license)", for: .normal)
            } else {
                self.licenseButton.isHidden = true
            }
            
            if let language = model?.language {
                self.languageLabel.isHidden = false
                self.languageLabel.text = "\(language)" 
                
                let dict = Languages.colorDict()[language] as? NSDictionary
                
                if let colorStr = dict?["color"] as? String {
                    let color = UIColor(hexString: colorStr)
                    self.languageColorView.isHidden = false
                    self.languageColorView.backgroundColor = color
                } else {
                    self.languageColorView.isHidden = true
                }
                
            } else {
                self.languageColorView.isHidden = true
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
