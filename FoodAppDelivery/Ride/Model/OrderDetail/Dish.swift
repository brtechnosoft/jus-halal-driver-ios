//
//  Dish.swift
//  FoodAppDelivery
//
//  Created by Pyramidions on 21/02/19.
//  Copyright © 2019 Pyramidions. All rights reserved.
//

import Foundation

struct Dish: Codable {
    
    let displayDish: String?
    let isVeg, dishTotal: Int?
    let displayPrice: String?
    
    enum CodingKeys: String, CodingKey {
        case displayDish = "dishplayDish"
        case isVeg, dishTotal, displayPrice
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        displayDish = try values.decodeIfPresent(String.self, forKey: .displayDish)
        isVeg = try values.decodeIfPresent(Int.self, forKey: .isVeg)
        dishTotal = try values.decodeIfPresent(Int.self, forKey: .dishTotal)
        displayPrice = try values.decodeIfPresent(String.self, forKey: .displayPrice)
    }
}
