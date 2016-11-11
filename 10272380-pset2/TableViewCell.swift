//
//  TableViewCell.swift
//  10272380-pset2
//
//  Created by Quinten van der Post on 10/11/2016.
//  Copyright © 2016 Quinten van der Post. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var wordCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
