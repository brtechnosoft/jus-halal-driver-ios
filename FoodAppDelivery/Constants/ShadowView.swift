//
//  ShadowView.swift
//  FoodAppUser
//
//  Created by Pyramidions on 02/02/19.
//  Copyright © 2019 Pyramidions. All rights reserved.
//

import Foundation
import UIKit
import MaterialComponents

class ShadowView: UIView {
    
    override class var layerClass: AnyClass {
        return MDCShadowLayer.self
    }
    
    var shadowLayer: MDCShadowLayer {
        return self.layer as! MDCShadowLayer
    }
    
    func setDefaultElevation() {
        self.shadowLayer.elevation = ShadowElevation.cardResting
    }
    
}
