//
//  OrderDetails.swift
//  FoodAppDelivery
//
//  Created by Pyramidions on 21/02/19.
//  Copyright © 2019 Pyramidions. All rights reserved.
//

import Foundation

/*
struct OrderDetails : Codable {
    let orderReferenceId : String?
    let userMobileNumber : String?
    let outletAddress : String?
    let outletName : String?
    let userAddress : String?
    let outletMobileNumber : String?
    let dishes : [Dishes]?
    let netAmount : String?
    let userName : String?
    let charges : [Charges]?
    let displayNetAmount : String?
    let orderStatusTime : String?
    let orderStatus : String?
    
    enum CodingKeys: String, CodingKey {
        
        case orderReferenceId = "orderReferenceId"
        case userMobileNumber = "userMobileNumber"
        case outletAddress = "outletAddress"
        case outletName = "outletName"
        case userAddress = "userAddress"
        case outletMobileNumber = "outletMobileNumber"
        case dishes = "dishes"
        case netAmount = "netAmount"
        case userName = "userName"
        case charges = "charges"
        case displayNetAmount = "displayNetAmount"
        case orderStatusTime = "orderStatusTime"
        case orderStatus = "orderStatus"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        orderReferenceId = try values.decodeIfPresent(String.self, forKey: .orderReferenceId)
        userMobileNumber = try values.decodeIfPresent(String.self, forKey: .userMobileNumber)
        outletAddress = try values.decodeIfPresent(String.self, forKey: .outletAddress)
        outletName = try values.decodeIfPresent(String.self, forKey: .outletName)
        userAddress = try values.decodeIfPresent(String.self, forKey: .userAddress)
        outletMobileNumber = try values.decodeIfPresent(String.self, forKey: .outletMobileNumber)
        dishes = try values.decodeIfPresent([Dishes].self, forKey: .dishes)
        netAmount = try values.decodeIfPresent(String.self, forKey: .netAmount)
        userName = try values.decodeIfPresent(String.self, forKey: .userName)
        charges = try values.decodeIfPresent([Charges].self, forKey: .charges)
        displayNetAmount = try values.decodeIfPresent(String.self, forKey: .displayNetAmount)
        orderStatusTime = try values.decodeIfPresent(String.self, forKey: .orderStatusTime)
        orderStatus = try values.decodeIfPresent(String.self, forKey: .orderStatus)
    }
    
}


struct Dishes : Codable {
    let isVeg : String?
    let dishplayDish : String?
    let quantity : Int?
    let dishTotal : Int?
    let displayPrice : String?
    
    enum CodingKeys: String, CodingKey {
        
        case isVeg = "isVeg"
        case dishplayDish = "dishplayDish"
        case quantity = "quantity"
        case dishTotal = "dishTotal"
        case displayPrice = "displayPrice"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        isVeg = try values.decodeIfPresent(String.self, forKey: .isVeg)
        dishplayDish = try values.decodeIfPresent(String.self, forKey: .dishplayDish)
        quantity = try values.decodeIfPresent(Int.self, forKey: .quantity)
        dishTotal = try values.decodeIfPresent(Int.self, forKey: .dishTotal)
        displayPrice = try values.decodeIfPresent(String.self, forKey: .displayPrice)
    }
    
}

struct Charges : Codable {
    let itemTotal : Int?
    let displayKey : String?
    let displayValue : String?
    let percentage : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case itemTotal = "itemTotal"
        case displayKey = "displayKey"
        case displayValue = "displayValue"
        case percentage = "percentage"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        itemTotal = try values.decodeIfPresent(Int.self, forKey: .itemTotal)
        displayKey = try values.decodeIfPresent(String.self, forKey: .displayKey)
        displayValue = try values.decodeIfPresent(String.self, forKey: .displayValue)
        percentage = try values.decodeIfPresent(Int.self, forKey: .percentage)
    }
    
}




/*
struct OrderDetails: Codable {
    let orderStatus, orderReferenceID, orderStatusTime, outletName: String?
    let outletAddress, outletMobileNumber, userName, userMobileNumber: String?
    let userAddress: String?
    let dishes: [Dish]?
    let netAmount, displayNetAmount: String?
    let charges: [Charge]?
    
    enum CodingKeys: String, CodingKey {
        case orderStatus
        case orderReferenceID = "orderReferenceId"
        case orderStatusTime, outletName, outletAddress, outletMobileNumber, userName, userMobileNumber, userAddress, dishes, netAmount, displayNetAmount, charges
    }
    
    init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        orderStatus = try values.decodeIfPresent(String.self, forKey: .orderStatus)
        orderReferenceID = try values.decodeIfPresent(String.self, forKey:.orderReferenceID)
        orderStatusTime = try values.decodeIfPresent(String.self, forKey: .orderStatusTime)
        outletName = try values.decodeIfPresent(String.self, forKey: .outletName)
        outletAddress = try values.decodeIfPresent(String.self, forKey: .outletAddress)
        outletMobileNumber = try values.decodeIfPresent(String.self, forKey: .outletMobileNumber)
        userName = try values.decodeIfPresent(String.self, forKey: .userName)
        userMobileNumber = try values.decodeIfPresent(String.self, forKey: .userMobileNumber)
        userAddress = try values.decodeIfPresent(String.self, forKey: .userAddress)
        dishes = try values.decodeIfPresent([Dish].self, forKey: .dishes)
        netAmount = try values.decodeIfPresent(String.self, forKey: .netAmount)
        displayNetAmount = try values.decodeIfPresent(String.self, forKey: .displayNetAmount)
        charges = try values.decodeIfPresent([Charge].self, forKey: .charges)
    }
}
*/
*/
