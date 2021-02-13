//
//  ListPastOrderDetailModel.swift
//  FoodAppDelivery
//
//  Created by Pyramidions on 16/02/19.
//  Copyright © 2019 Pyramidions. All rights reserved.
//

import Foundation

struct ListPastOrder: Codable {
   
    let orderID: Int?
    let customerDetails: CustomerDetails?
    let restaurantDetails: RestaurantDetails?
    
    enum CodingKeys: String, CodingKey {
        case orderID = "orderId"
        case customerDetails = "usersDetails"
        case restaurantDetails = "outletDetails"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        orderID = try values.decodeIfPresent(Int.self, forKey: .orderID)
        customerDetails = try values.decodeIfPresent(CustomerDetails.self, forKey: .customerDetails)
        restaurantDetails = try values.decodeIfPresent(RestaurantDetails.self, forKey: .restaurantDetails)
        
    }
}
