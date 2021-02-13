//
//  RideDetailModel.swift
//  FoodAppDelivery
//
//  Created by Pyramidions on 16/02/19.
//  Copyright © 2019 Pyramidions. All rights reserved.
//

import Foundation

struct RideDetailModel: Codable {
    let error: String?
    let errorMessage: String?
    let deliveryDetail: DeliveryDetail?
    
    enum CodingKeys : String, CodingKey {
        case error
        case errorMessage
        case deliveryDetail
    }
    
    init(from decoder:Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        error = try values.decodeIfPresent(String.self, forKey: .error)
        errorMessage = try values.decodeIfPresent(String.self, forKey: .errorMessage)
        deliveryDetail = try values.decodeIfPresent(DeliveryDetail.self, forKey: .deliveryDetail)
    }
}


