//
//  OrdersListModel.swift
//  FoodAppDelivery
//
//  Created by Pyramidions on 16/02/19.
//  Copyright © 2019 Pyramidions. All rights reserved.
//

import Foundation

struct OrdersListModel: Codable {
    let error, errorMessage: String?
    let listPastOrders: [ListPastOrder]?
    
    enum CodingKeys : String, CodingKey {
        case error
        case errorMessage
        case listPastOrders
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        error = try values.decodeIfPresent(String.self, forKey: .error)
        errorMessage = try values.decodeIfPresent(String.self, forKey: .errorMessage)
        listPastOrders = try values.decodeIfPresent([ListPastOrder].self, forKey: .listPastOrders)
    }
}
