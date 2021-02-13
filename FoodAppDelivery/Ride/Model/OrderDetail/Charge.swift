//
//  Charge.swift
//  FoodAppDelivery
//
//  Created by Pyramidions on 05/03/19.
//  Copyright © 2019 Pyramidions. All rights reserved.
//

import Foundation

struct Charge: Codable {
   
    let displayKey, displayValue: String?
    let itemTotal: Int?
    let id, status: Int?
    
    enum CodingKeys: String, CodingKey {
        case displayKey, displayValue
        case itemTotal, id, status
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        displayKey = try values.decodeIfPresent(String.self, forKey: .displayKey)
        displayValue = try values.decodeIfPresent(String.self, forKey: .displayValue)
        itemTotal = try values.decodeIfPresent(Int.self, forKey: .itemTotal)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
    }
}
