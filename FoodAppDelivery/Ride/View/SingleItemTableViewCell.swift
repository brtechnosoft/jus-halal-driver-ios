//
//  SingleItemTableViewCell.swift
//  FoodAppDelivery
//
//  Created by Pyramidions on 19/02/19.
//  Copyright © 2019 Pyramidions. All rights reserved.
//

import UIKit

class SingleItemTableViewCell: UITableViewCell {
    @IBOutlet weak var imgType: UIImageView!
    @IBOutlet weak var dishNameLbl: UILabel!
    
    @IBOutlet weak var addonsView: UIView!
    @IBOutlet weak var addonsLbl: UILabel!
    @IBOutlet weak var addonsHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var addonsTableView: UITableView!
    @IBOutlet weak var dishPriceLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        dishNameLbl.font = MuliFontBook.SemiBold.of(size: 14)
        dishPriceLbl.font = MuliFontBook.SemiBold.of(size: 14)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
