//
//  RestaurantDetailModel.swift
//  FoodAppDelivery
//
//  Created by Pyramidions on 16/02/19.
//  Copyright © 2019 Pyramidions. All rights reserved.
//

import Foundation

struct RestaurantDetails: Codable {
    let restaurantName, restaurantAddress, restaurantPhoneNo, orderStatus: String?
    
    enum CodingKeys : String, CodingKey {
        case restaurantName = "outletName"
        case restaurantAddress = "outletAddress"
        case restaurantPhoneNo = "outletMobileNumber"
        case orderStatus = "orderStatus"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        restaurantName = try values.decodeIfPresent(String.self, forKey: .restaurantName)
        restaurantAddress = try values.decodeIfPresent(String.self, forKey: .restaurantAddress)
        restaurantPhoneNo = try values.decodeIfPresent(String.self, forKey: .restaurantPhoneNo)
        orderStatus = try values.decodeIfPresent(String.self, forKey: .orderStatus)
    }
}
