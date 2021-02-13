//
//  BillDetailTableViewCell.swift
//  FoodAppDelivery
//
//  Created by Pyramidions on 05/03/19.
//  Copyright © 2019 Pyramidions. All rights reserved.
//

import UIKit

class BillDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var displayName: UILabel!
    @IBOutlet weak var displayAmount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        displayName.font = MuliFontBook.SemiBold.of(size: 14)
        displayAmount.font = MuliFontBook.SemiBold.of(size: 14)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
