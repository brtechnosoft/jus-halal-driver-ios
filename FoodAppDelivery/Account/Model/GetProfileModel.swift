//
//  GetProfileModel.swift
//  FoodAppDelivery
//
//  Created by Pyramidions on 22/02/19.
//  Copyright © 2019 Pyramidions. All rights reserved.
//

import Foundation

struct GetProfileModel: Codable {
    let error, errorMessage: String?
    let staffProfile: StaffProfile?
    
    enum CodingKeys: String, CodingKey {
        case error, errorMessage, staffProfile
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        error = try values.decodeIfPresent(String.self, forKey: .error)
        errorMessage = try values.decodeIfPresent(String.self, forKey: .errorMessage)
        staffProfile = try values.decodeIfPresent(StaffProfile.self, forKey: .staffProfile)
    }
}

struct StaffProfile: Codable {
    let id: Int?
    let name, mobileNumber, email, countryCode: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, mobileNumber, email, countryCode
        
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        mobileNumber = try values.decodeIfPresent(String.self, forKey: .mobileNumber)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        countryCode = try values.decodeIfPresent(String.self, forKey: .countryCode)
    }
}
