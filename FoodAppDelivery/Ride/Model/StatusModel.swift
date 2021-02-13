//
//  StatusModel.swift
//  FoodAppDelivery
//
//  Created by Pyramidions on 16/02/19.
//  Copyright © 2019 Pyramidions. All rights reserved.
//

import Foundation

struct StatusModel : Codable{
    let error : String?
    let errorMessage : String?
    
    enum CodingKeys: String, CodingKey {
        case error
        case errorMessage
    }
    
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        error = try values.decodeIfPresent(String.self, forKey: .error)
        errorMessage = try values.decodeIfPresent(String.self, forKey: .errorMessage)
    }
}
