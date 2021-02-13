//
//  OrderListTableViewCell.swift
//  FoodAppDelivery
//
//  Created by Pyramidions on 16/02/19.
//  Copyright © 2019 Pyramidions. All rights reserved.
//

import UIKit


protocol OrderStatusDelegate: class {
    func acceptOrder()
    func rejectOrder()
}

class OrderListTableViewCell: UITableViewCell {

    @IBOutlet weak var shadowView: ShadowView!
    @IBOutlet weak var restaurantNameLbl: UILabel!
    @IBOutlet weak var restaurantAddressLbl: UILabel!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var userAddressLbl: UILabel!
    @IBOutlet weak var orderNumberLbl: UILabel!
    @IBOutlet weak var paidViaLbl: UILabel!
    @IBOutlet weak var btnAccept: UIButton!
    @IBOutlet weak var btnDecline: UIButton!
    @IBOutlet weak var actionViewHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var actionView: UIView!
    @IBOutlet weak var mainView: UIView!
    weak var delegate : OrderStatusDelegate?
    
    @IBOutlet weak var statusBGImg: UIImageView!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var statusView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
         mainView.layer.cornerRadius = 5
         mainView.layer.masksToBounds = true
         shadowView.layer.cornerRadius = 5
         shadowView.setDefaultElevation()
        
        btnAccept.setTitle("Accept".localized(), for: .normal)
        btnDecline.setTitle("Reject".localized(), for: .normal)
        btnDecline.layer.borderWidth = 1.0
        btnDecline.layer.borderColor = UIColor(hexString: "#E93751").cgColor
        
        setFont()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 5, bottom: 8, right: 5))
    }
    
    @IBAction func acceptAtn(_ sender: Any) {
        
        delegate?.acceptOrder()
    }
    
    @IBAction func declineBtn(_ sender: Any) {
        delegate?.rejectOrder()
    }
    
    func setFont()
    {
        restaurantNameLbl.font = MuliFontBook.SemiBold.of(size: 14)
        restaurantAddressLbl.font = MuliFontBook.SemiBold.of(size: 14)
        userNameLbl.font = MuliFontBook.SemiBold.of(size: 14)
        userAddressLbl.font = MuliFontBook.SemiBold.of(size: 14)
        orderNumberLbl.font = MuliFontBook.SemiBold.of(size: 12)
        btnAccept.titleLabel?.font = MuliFontBook.SemiBold.of(size: 14)
        btnDecline.titleLabel?.font = MuliFontBook.SemiBold.of(size: 14)
        
    }
    
}
