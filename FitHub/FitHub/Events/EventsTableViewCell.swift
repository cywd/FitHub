//
//  EventsTableViewCell.swift
//  FitHub
//
//  Created by Cyrill on 2017/12/4.
//  Copyright © 2017年 Cyrill. All rights reserved.
//

import UIKit

class EventsTableViewCell: UITableViewCell, RegisterCellOrNib {
    
    @IBOutlet weak var label: UILabel!

    var model: EventModel? {
        didSet {
            self.label?.text = model!.finDesc ?? " "
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
