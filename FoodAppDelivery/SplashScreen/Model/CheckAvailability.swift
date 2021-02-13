//
//  CheckAvailability.swift
//  FoodAppDelivery
//
//  Created by Pyramidions on 11/02/19.
//  Copyright © 2019 Pyramidions. All rights reserved.
//

import Foundation

struct CheckAvailability: Codable {
    let error, errorMessage, isNewDeliveryStaff: String?
    let otpNumber: Int?
    let timeDelayForOtp: String?
    
    enum CodingKeys: String, CodingKey
    {
        case error, errorMessage, isNewDeliveryStaff, timeDelayForOtp
        case otpNumber
    }
    
    init(from decoder:Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        error = try values.decodeIfPresent(String.self, forKey: .error)
        errorMessage = try values.decodeIfPresent(String.self, forKey: .errorMessage)
        isNewDeliveryStaff = try values.decodeIfPresent(String.self, forKey: .isNewDeliveryStaff)
        timeDelayForOtp = try values.decodeIfPresent(String.self, forKey: .timeDelayForOtp)
        otpNumber = try values.decodeIfPresent(Int.self, forKey: .otpNumber)

    }
}
