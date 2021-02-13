//
//  OtpVerification.swift
//  FoodAppDelivery
//
//  Created by Pyramidions on 12/02/19.
//  Copyright © 2019 Pyramidions. All rights reserved.
//

import Foundation


struct OtpVerification : Codable
{
    let error : String?
    let errorMessage : String?
    let isOtpVerified : String?
    
    enum CodingKeys: String, CodingKey
    {
        case error = "error"
        case errorMessage = "errorMessage"
        case isOtpVerified = "isOtpVerified"
    }
    
    init(from decoder: Decoder) throws
    {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        error = try values.decodeIfPresent(String.self, forKey: .error)
        errorMessage = try values.decodeIfPresent(String.self, forKey: .errorMessage)
        isOtpVerified = try values.decodeIfPresent(String.self, forKey: .isOtpVerified)
    }
}
