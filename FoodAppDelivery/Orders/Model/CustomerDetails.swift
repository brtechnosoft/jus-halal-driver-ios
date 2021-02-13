//
//  CustomerDetailModel.swift
//  FoodAppDelivery
//
//  Created by Pyramidions on 16/02/19.
//  Copyright © 2019 Pyramidions. All rights reserved.
//

import Foundation

struct CustomerDetails: Codable {
    let userName, userAddress, userPhoneNo, orderRefferenceID: String?
    let totalAmount, paymentType: String?
    
    enum CodingKeys: String, CodingKey {
        case userName, userAddress
        case userPhoneNo = "userMobileNumber"
        case orderRefferenceID = "orderRefferenceId"
        case totalAmount = "netAmount"
        case paymentType
    }
    
    init(from decoder : Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userName = try values.decodeIfPresent(String.self, forKey: .userName)
        userAddress = try values.decodeIfPresent(String.self, forKey: .userAddress)
        userPhoneNo = try values.decodeIfPresent(String.self, forKey: .userPhoneNo)
        orderRefferenceID = try values.decodeIfPresent(String.self, forKey: .orderRefferenceID)
        totalAmount = try values.decodeIfPresent(String.self, forKey: .totalAmount)
        paymentType = try values.decodeIfPresent(String.self, forKey: .paymentType)
    }
}
