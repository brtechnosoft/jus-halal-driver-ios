//
//  SignUpModel.swift
//  FoodAppDelivery
//
//  Created by Pyramidions on 12/03/19.
//  Copyright © 2019 Pyramidions. All rights reserved.
//

import Foundation

struct SignUpModel: Codable {
    let error, errorMessage: String?
    let signupFields: [SignupField]?
    
    enum CodingKeys : String, CodingKey {
        case error
        case errorMessage
        case signupFields
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        error = try values.decodeIfPresent(String.self, forKey: .error)
        errorMessage = try values.decodeIfPresent(String.self, forKey: .errorMessage)
        signupFields = try values.decodeIfPresent([SignupField].self, forKey: .signupFields)
    }
}

struct SignupField: Codable {
    let fields: [Field]?
    let page: Int?
    let pageName: String?
    
    enum CodingKeys : String, CodingKey {
        case fields
        case page
        case pageName
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        fields = try values.decodeIfPresent([Field].self, forKey: .fields)
        page = try values.decodeIfPresent(Int.self, forKey: .page)
        pageName = try values.decodeIfPresent(String.self, forKey: .pageName)
    }
}


struct Field: Codable {
 
    let fieldName, fieldKey: String?
    let fieldType: FieldType?
    let type: TypeEnum?
    let validationType: String?
    
    enum CodingKeys : String, CodingKey {
        case fieldName, fieldKey, validationType
        case type, fieldType
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        fieldName = try values.decodeIfPresent(String.self, forKey: .fieldName)
        fieldKey = try values.decodeIfPresent(String.self, forKey: .fieldKey)
        validationType = try values.decodeIfPresent(String.self, forKey: .validationType)
        type = try values.decodeIfPresent(TypeEnum.self, forKey: .type)
        fieldType = try values.decodeIfPresent(FieldType.self, forKey: .fieldType)
    }
}

enum FieldType: String, Codable {
    case edittext = "EDITTEXT"
}

enum TypeEnum: String, Codable {
    case number = "NUMBER"
    case string = "STRING"
    case text = "TEXT"
}

