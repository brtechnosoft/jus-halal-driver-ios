//
//  OTPLogin.swift
//  FoodAppDelivery
//
//  Created by Pyramidions on 12/02/19.
//  Copyright © 2019 Pyramidions. All rights reserved.
//

import Foundation

struct OTPLogin: Codable {
    let error, errorMessage, isNewDeliveryStaff, accessToken: String?
    let otpVerified: String?
    let staffDetails: StaffDetails?
    
    enum CodingKeys: String, CodingKey
    {
        case error, errorMessage, isNewDeliveryStaff, otpVerified
        case staffDetails
        case accessToken = "accesstoken"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        error = try values.decodeIfPresent(String.self, forKey: .error)
        errorMessage = try values.decodeIfPresent(String.self, forKey: .errorMessage)
        isNewDeliveryStaff = try values.decodeIfPresent(String.self, forKey: .isNewDeliveryStaff)
        accessToken = try values.decodeIfPresent(String.self, forKey: .accessToken)
        otpVerified = try values.decodeIfPresent(String.self, forKey: .otpVerified)
        staffDetails = try values.decodeIfPresent(StaffDetails.self, forKey: .staffDetails)
    }
}

struct StaffDetails: Codable {
    let id: Int?
    let name, email, mobileNumber, countryCode: String?
    let password, documentation: String?
    let deviceToken, os, googleToken: String?
    let status: Int?
    let latitude, longitude: String?
    let isApproved: Int?
    let createdAt: String?
    let updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, email, mobileNumber, countryCode, password, documentation, deviceToken, os, googleToken, status, latitude, longitude, isApproved
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    init(from decoder: Decoder) throws {
      
        let values = try decoder.container(keyedBy: CodingKeys.self)
      
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        mobileNumber = try values.decodeIfPresent(String.self, forKey: .mobileNumber)
        countryCode = try values.decodeIfPresent(String.self, forKey: .countryCode)
        password = try values.decodeIfPresent(String.self, forKey: .password)
        documentation = try values.decodeIfPresent(String.self, forKey: .documentation)
        deviceToken = try values.decodeIfPresent(String.self, forKey: .deviceToken)
        os = try values.decodeIfPresent(String.self, forKey: .os)
        googleToken = try values.decodeIfPresent(String.self, forKey: .googleToken)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        latitude = try values.decodeIfPresent(String.self, forKey: .latitude)
        longitude = try values.decodeIfPresent(String.self, forKey: .longitude)
        isApproved = try values.decodeIfPresent(Int.self, forKey: .isApproved)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
    }
}
