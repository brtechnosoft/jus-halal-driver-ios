//
//  GetOrderModel.swift
//  FoodAppDelivery
//
//  Created by Pyramidions on 20/02/19.
//  Copyright © 2019 Pyramidions. All rights reserved.
//

import Foundation

struct GetOrderModel: Codable {
    let error, errorMessage: String?
    let orders: Orders?
    
    enum CodingKeys : String, CodingKey
    {
        case error, errorMessage, orders
    }
    
    init(from decoder:Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        error = try values.decodeIfPresent(String.self, forKey: .error)
        errorMessage = try values.decodeIfPresent(String.self, forKey: .errorMessage)
        orders = try values.decodeIfPresent(Orders.self, forKey: .orders)
    }
}

struct Orders: Codable {
    let orderID: Int?
    let orderReferenceID, usersAddress, deliveryAddressType, userName: String?
    let outletName, outletAddress, netAmount, paidVia: String?
    let orderStatus: String?
    
    enum CodingKeys: String, CodingKey {
        case orderID = "orderId"
        case orderReferenceID = "orderReferenceId"
        case usersAddress, deliveryAddressType, userName, outletName, outletAddress, netAmount, paidVia, orderStatus
    }
    
    init(from decoder:Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        orderID = try values.decodeIfPresent(Int.self, forKey: .orderID)
        orderReferenceID = try values.decodeIfPresent(String.self, forKey: .orderReferenceID)
        usersAddress = try values.decodeIfPresent(String.self, forKey: .usersAddress)
        deliveryAddressType = try values.decodeIfPresent(String.self, forKey: .deliveryAddressType)
        userName = try values.decodeIfPresent(String.self, forKey: .userName)
        outletName = try values.decodeIfPresent(String.self, forKey: .outletName)
        outletAddress = try values.decodeIfPresent(String.self, forKey: .outletAddress)
        netAmount = try values.decodeIfPresent(String.self, forKey: .netAmount)
        paidVia = try values.decodeIfPresent(String.self, forKey: .paidVia)
        orderStatus = try values.decodeIfPresent(String.self, forKey: .orderStatus)
    }
}
