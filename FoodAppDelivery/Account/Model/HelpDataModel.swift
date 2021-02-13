//
//  HelpDataModel.swift
//  FoodAppDelivery
//
//  Created by Pyramidions on 23/02/19.
//  Copyright © 2019 Pyramidions. All rights reserved.
//

import Foundation

struct HelpDataModel: Codable {
    let error, errorMessage: String?
    let faqPages: String?
    
    enum CodingKeys: String, CodingKey {
        case error
        case errorMessage
        case faqPages
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        error = try values.decodeIfPresent(String.self, forKey: .error)
        errorMessage = try values.decodeIfPresent(String.self, forKey: .errorMessage)
        faqPages = try values.decodeIfPresent(String.self, forKey: .faqPages)
    }
    
}
