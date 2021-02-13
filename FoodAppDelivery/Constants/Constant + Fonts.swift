//
//  Constant + Fonts.swift
//  FoodAppDelivery
//
//  Created by Pyramidions on 16/02/19.
//  Copyright © 2019 Pyramidions. All rights reserved.
//

import Foundation
import UIKit

// AktivGrotesk fonts
enum AktivGroteskFontBook: String
{
    case Regular = "AktivGrotesk"
    case Medium = "Aktivgrotesk-medium"
    case Bold = "AktivGrotesk-Bold"
    case BoldItalic = "AktivGroteskBoldItalic"
    case Italic = "AktivGroteskItalic"
    case light = "AktivGroteskLight"
    case LightItalic = "AktivGroteskLightItalic"
    
    
    
    func of(size: CGFloat) -> UIFont
    {
        return UIFont(name: self.rawValue, size: size)!
    }
}

//Muli Fonts

enum MuliFontBook : String {
    
    case Bold = "Muli-Bold"
    case Regular = "Muli-Regular"
    case SemiBold = "Muli-SemiBold"
    
    func of(size: CGFloat) -> UIFont
    {
        return UIFont(name: self.rawValue, size: size)!
    }
}

// Raleway Fonts

enum RalewayFont : String
{
    case SemiBold = "Raleway-SemiBold"
    
    func of(size: CGFloat) -> UIFont
    {
        return UIFont(name: self.rawValue, size: size)!
    }
}

// Archivo Fonts

enum Archivo : String
{
    case Regular = "Archivo-Regular"
    
    func of(size: CGFloat) -> UIFont
    {
        return UIFont(name: self.rawValue, size: size)!
    }
}
