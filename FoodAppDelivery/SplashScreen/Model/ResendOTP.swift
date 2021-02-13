//
//  ResendOTP.swift
//  FoodAppDelivery
//
//  Created by Pyramidions on 12/02/19.
//  Copyright © 2019 Pyramidions. All rights reserved.
//

import Foundation

struct ResendOTP : Codable
{
    let error : String?
    let error_message : String?
    let otpNumber : Int?
    let timeDelayForOtp : String?
    
    enum CodingKeys: String, CodingKey
    {
        case error = "error"
        case error_message = "errorMessage"
        case otpNumber = "otpNumber"
        case timeDelayForOtp = "timeDelayForOtp"
    }
    
    init(from decoder: Decoder) throws
    {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        error = try values.decodeIfPresent(String.self, forKey: .error)
        error_message = try values.decodeIfPresent(String.self, forKey: .error_message)
        otpNumber = try values.decodeIfPresent(Int.self, forKey: .otpNumber)
        timeDelayForOtp = try values.decodeIfPresent(String.self, forKey: .timeDelayForOtp)
    }
}
