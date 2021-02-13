//
//  Constant+Extenstion.swift
//  FoodAppDelivery
//
//  Created by Pyramidions on 11/02/19.
//  Copyright © 2019 Pyramidions. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController
{
    func showAlertError(titleStr:String = "Error".localized(), messageStr:String)
    {
        let alert = UIAlertController(title: titleStr, message: messageStr, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok".localized(), style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func hideKeyboardWhenTappedAround()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
}

extension UIView
{
    
    func showCountryView()  {
        
        UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: .calculationModeCubicPaced, animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5) {
                
                self.isHidden = false
                self.transform = .identity
                
            }
            
        }, completion: { finished in
            
        })
        
    }
    
    func hideCountryView()
    {
        UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: .calculationModeCubicPaced, animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5) {
                
                self.transform = CGAffineTransform(scaleX: 0, y: 0)
            }
        }, completion: { finished in
            
            self.isHidden = true
        })
    }
    
    func shake()
    {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.5
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}

extension UIButton
{
    func hideAndShow(hidden: Bool)
    {
        UIView.transition(with: self, duration: 0.3, options: .transitionFlipFromTop, animations:
            {
                self.isHidden = hidden
        })
    }
    
    func buttonShake()
    {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}

extension UILabel {
  
    func setDifferentColor(firstString: String, secondString: String){
        
        let firstStr = [NSAttributedString.Key.font : MuliFontBook.SemiBold.of(size: 12), NSAttributedString.Key.foregroundColor :UIColor(named: "NavyBlue")]
        
        let attributedString1 = NSMutableAttributedString(string:firstString, attributes:firstStr as [NSAttributedString.Key : Any])
        
        let secondStr = [NSAttributedString.Key.font : MuliFontBook.SemiBold.of(size: 12), NSAttributedString.Key.foregroundColor :  UIColor(named: "orangeColor")]
        
        let attributedString2 = NSMutableAttributedString(string:secondString, attributes:secondStr as [NSAttributedString.Key : Any])
        let str = NSAttributedString(string: " ")
        
        attributedString1.append(str)
        attributedString1.append(attributedString2)
        attributedText = attributedString1
        
    }
}

extension UIColor
{
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
   
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
}


extension String {
    
    enum RegularExpressions: String {
        case phone = "^\\s*(?:\\+?(\\d{1,3}))?([-. (]*(\\d{3})[-. )]*)?((\\d{3})[-. ]*(\\d{2,4})(?:[-.x ]*(\\d+))?)\\s*$"
    }
    
    func isValid(regex: RegularExpressions) -> Bool {
        return isValid(regex: regex.rawValue)
    }
    
    func isValid(regex: String) -> Bool {
        let matches = range(of: regex, options: .regularExpression)
        return matches != nil
    }
    
    func onlyDigits() -> String {
        let filtredUnicodeScalars = unicodeScalars.filter{CharacterSet.decimalDigits.contains($0)}
        return String(String.UnicodeScalarView(filtredUnicodeScalars))
    }
    
    func makeAColl() {
        if isValid(regex: .phone) {
            if let url = URL(string: "tel://\(self.onlyDigits())"), UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }
        else{
            print("IT's  not a valid phone number")
        }
    }
}

