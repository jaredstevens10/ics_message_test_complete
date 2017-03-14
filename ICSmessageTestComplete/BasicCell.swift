//
//  BasicCell.swift
//  ICSmessageTestComplete
//
//  Created by Jared Stevens2 on 1/9/17.
//  Copyright © 2017 Jared Stevens. All rights reserved.
//

import UIKit

class BasicCell: UITableViewCell {
    
    
    @IBOutlet weak var messageLBL: UILabel!
    
    @IBOutlet weak var dateLBL: UILabel!
    
    @IBOutlet weak var userLBL: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
