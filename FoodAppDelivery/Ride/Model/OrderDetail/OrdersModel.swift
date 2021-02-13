//
//  OrdersModel.swift
//  FoodAppDelivery
//
//  Created by Pyramidions on 21/02/19.
//  Copyright © 2019 Pyramidions. All rights reserved.
//

import Foundation

/*
struct OrdersModel: Codable {
    let error, errorMessage: String?
    let orderDetails: OrderDetails?
    
    enum CodingKeys : String, CodingKey
    {
        case error
        case errorMessage
        case orderDetails
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        error = try values.decodeIfPresent(String.self, forKey: .error)
        errorMessage = try values.decodeIfPresent(String.self, forKey: .errorMessage)
        orderDetails = try values.decodeIfPresent(OrderDetails.self, forKey: .orderDetails)
    }
}
*/

/*

struct OrdersModel : Codable {
    let errorMessage : String?
    let error : String?
    let orderDetails : OrderDetails?
    
    enum CodingKeys: String, CodingKey {
        
        case errorMessage = "errorMessage"
        case error = "error"
        case orderDetails = "orderDetails"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        errorMessage = try values.decodeIfPresent(String.self, forKey: .errorMessage)
        error = try values.decodeIfPresent(String.self, forKey: .error)
        orderDetails = try values.decodeIfPresent(OrderDetails.self, forKey: .orderDetails)
    }
    
}

*/

struct OrdersModel: Codable {
    let orderDetails: OrderDetails
    let error, errorMessage: String
}

// MARK: - OrderDetails
struct OrderDetails: Codable {
    let orderStatusTime: String
    let dishes: [Dishes]
    let displayNetAmount, outletMobileNumber: String
    let charges: [Charges]
    let userAddress, outletAddress, userMobileNumber, userName: String
    let orderStatus, netAmount, outletName, orderReferenceID: String
    
    enum CodingKeys: String, CodingKey {
        case orderStatusTime, dishes, displayNetAmount, outletMobileNumber, charges, userAddress, outletAddress, userMobileNumber, userName, orderStatus, netAmount, outletName
        case orderReferenceID = "orderReferenceId"
    }
}

// MARK: - Charge
struct Charges: Codable {
    let percentage: Percentage?
    let itemTotal: Int?
    let displayKey, displayValue: String
    let id, status: Int?
}

enum Percentage: Codable {
    case integer(Int)
    case string(String)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Percentage.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Percentage"))
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Dish
struct Dishes: Codable {
    let quantity, dishTotal: Int
    let dishplayDish, isVeg, displayPrice: String
}
