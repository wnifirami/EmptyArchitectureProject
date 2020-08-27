//
//  UserCell.swift
//  EmptyArchitectureProject
//
//  Created by Rami Ounifi on 6/23/20.
//  Copyright © 2020 Yellow. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet weak var descriptionUser: UILabel!
    @IBOutlet weak var titleUser: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
