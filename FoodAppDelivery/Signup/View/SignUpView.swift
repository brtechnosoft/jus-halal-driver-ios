//
//  SignUpView.swift
//  FoodAppDelivery
//
//  Created by Pyramidions on 14/03/19.
//  Copyright © 2019 Pyramidions. All rights reserved.
//

import Foundation

class SignUpView : UIView
{
    func viewWithTextField(lblName : String, txtFieldValue : String, width : CGFloat, isPassword: String) -> UIView
    {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: width, height: 60))
        
        let lbl = UILabel.init(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 30))
        lbl.text = lblName
        lbl.font = MuliFontBook.SemiBold.of(size: 14)
        view.addSubview(lbl)
        
        let txtFdl = UITextField.init(frame: CGRect(x: 0, y: lbl.frame.origin.y + 30, width: view.frame.width, height: 30))
        txtFdl.text = txtFieldValue
        if isPassword == "true"
        {
            txtFdl.isSecureTextEntry = true
        }
        txtFdl.font = MuliFontBook.SemiBold.of(size: 12)
        view.addSubview(txtFdl)
        
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor.darkGray.cgColor
        border.frame = CGRect(x: 0, y: txtFdl.frame.size.height - 1, width: txtFdl.frame.size.width-40, height: txtFdl.frame.size.height)
        
        border.borderWidth = width
        txtFdl.layer.addSublayer(border)
        txtFdl.layer.masksToBounds = true
        
        return view
    }
}
