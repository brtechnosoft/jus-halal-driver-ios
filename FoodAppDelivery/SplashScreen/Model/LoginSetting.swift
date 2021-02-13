//
//  LoginSetting.swift
//  FoodAppDelivery
//
//  Created by Pyramidions on 08/02/19.
//  Copyright © 2019 Pyramidions. All rights reserved.
//

import Foundation

struct LoginSetting: Codable {
   
    let error, errorMessage: String?
    let termsAndConditions: String?
    let iosMapKey, androidMapKey, browserKey, currency: String?
    let isPassword: String?
    
    enum CodingKeys : String, CodingKey {
        case error, errorMessage, termsAndConditions, iosMapKey, androidMapKey, browserKey, currency, isPassword
    }
    
    init(from decoder: Decoder) throws {
    
        let values = try decoder.container(keyedBy: CodingKeys.self)
    
        error = try values.decodeIfPresent(String.self, forKey: .error)
        errorMessage = try values.decodeIfPresent(String.self, forKey: .errorMessage)
        termsAndConditions = try values.decodeIfPresent(String.self, forKey: .termsAndConditions)
        iosMapKey = try values.decodeIfPresent(String.self, forKey: .iosMapKey)
        androidMapKey = try values.decodeIfPresent(String.self, forKey: .androidMapKey)
        browserKey = try values.decodeIfPresent(String.self, forKey: .browserKey)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        isPassword = try values.decodeIfPresent(String.self, forKey: .isPassword)

    }
    
}
