//
//  DeliveryDetailModel.swift
//  FoodAppDelivery
//
//  Created by Pyramidions on 16/02/19.
//  Copyright © 2019 Pyramidions. All rights reserved.
//

import Foundation

struct DeliveryDetail: Codable {
    
        let todayDisplayName, todayCost: String?
        let todayOrders: Int?
        let yesterdayDisplayName, yesterdayCost: String?
        let yesterdayOrders: Int?
        let weekDisplayName, weekCost: String?
        let weekOrders, tripStatus: Int?
        
        enum CodingKeys : String, CodingKey {
            case todayDisplayName, todayCost, todayOrders, weekDisplayName, weekCost, weekOrders,
            yesterdayDisplayName, yesterdayCost, yesterdayOrders, tripStatus
        }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        todayDisplayName = try values.decodeIfPresent(String.self, forKey: .todayDisplayName)
        todayCost = try values.decodeIfPresent(String.self, forKey: .todayCost)
        todayOrders = try values.decodeIfPresent(Int.self, forKey: .todayOrders)
        weekDisplayName = try values.decodeIfPresent(String.self, forKey: .weekDisplayName)
        weekCost = try values.decodeIfPresent(String.self, forKey: .weekCost)
        weekOrders = try values.decodeIfPresent(Int.self, forKey: .weekOrders)
        yesterdayDisplayName = try values.decodeIfPresent(String.self, forKey: .yesterdayDisplayName)
        yesterdayCost = try values.decodeIfPresent(String.self, forKey: .yesterdayCost)
        yesterdayOrders = try values.decodeIfPresent(Int.self, forKey: .yesterdayOrders)
        tripStatus = try values.decodeIfPresent(Int.self, forKey: .tripStatus)
    }
}

