//
//  Constant+UserDefaults.swift
//  FoodAppUser
//
//  Created by Pyramidions on 16/10/18.
//  Copyright © 2018 Pyramidions. All rights reserved.
//

import Foundation

extension UserDefaults
{
    func setLoggedIn(value: Bool)
    {
        set(value, forKey: UserDefaultsKeys.isLoggedIn.rawValue)
    }
    
    func isLoggedIn()-> Bool
    {
        return bool(forKey: UserDefaultsKeys.isLoggedIn.rawValue)
    }
    
    func setUserName(value: String)
    {
        set(value, forKey: UserDefaultsKeys.userName.rawValue)
    }
    
    func getUserName() -> String
    {
        guard string(forKey: UserDefaultsKeys.userName.rawValue) != nil  else {
            return ""
        }
        return string(forKey: UserDefaultsKeys.userName.rawValue)!
    }
    
    func setStaffAvailableStatus(value: Int)
    {
        set(value, forKey: UserDefaultsKeys.status.rawValue)
    }
    
    func getStaffAvailableStatus() -> Int
    {
        let value: Int? = integer(forKey: UserDefaultsKeys.status.rawValue)
      
        guard value != nil  else {
            return 0
        }
        return integer(forKey: UserDefaultsKeys.status.rawValue)
    }
    
    func setDeviceToken(value: String)
    {
        set(value, forKey: UserDefaultsKeys.deviceToken.rawValue)
    }
    
    func getDeviceToken() -> String
    {
        guard let deviceToken = string(forKey: UserDefaultsKeys.deviceToken.rawValue)
            else
        {
            return ""
        }
        return deviceToken
    }
    
    func setUserID(value: String)
    {
        set(value, forKey: UserDefaultsKeys.userID.rawValue)
    }
    
    func getUserID() -> String
    {
        guard string(forKey: UserDefaultsKeys.userID.rawValue) != nil  else {
            return ""
        }
        return string(forKey: UserDefaultsKeys.userID.rawValue)!
    }
    
    func setAccessToken(value: String)
    {
        set(value, forKey: UserDefaultsKeys.accessToken.rawValue)
    }
    
    func getAccessToken() -> String
    {
        guard let accessToken = string(forKey: UserDefaultsKeys.accessToken.rawValue)
            else
        {
            return ""
        }
        return accessToken
    }
    
    func setEmailID(value: String)
    {
        set(value, forKey: UserDefaultsKeys.emailID.rawValue)
    }
    
    func getEmailID() -> String
    {
        guard string(forKey: UserDefaultsKeys.emailID.rawValue) != nil else {
            return ""
        }
        return string(forKey: UserDefaultsKeys.emailID.rawValue)!
        
    }
    
    func setMobileNo(value: String)
    {
        set(value, forKey: UserDefaultsKeys.mobileNo.rawValue)
    }
    
    func getMobileNo() -> String
    {
        guard string(forKey: UserDefaultsKeys.mobileNo.rawValue) != nil  else {
            return ""
        }
        return string(forKey: UserDefaultsKeys.mobileNo.rawValue)!
    }
    
    func setTermsURL(value: String)
    {
        set(value, forKey: UserDefaultsKeys.termsURL.rawValue)
    }
    
    func getTermsURL() -> String
    {
        guard string(forKey: UserDefaultsKeys.termsURL.rawValue) != nil  else {
            return ""
        }
        return string(forKey: UserDefaultsKeys.termsURL.rawValue)!
    }
    
    func setMapKey(value: String)
    {
        set(value, forKey: UserDefaultsKeys.mapKey.rawValue)
    }
    
    func getMapKey() -> String
    {
        guard string(forKey: UserDefaultsKeys.mapKey.rawValue) != nil  else {
            return ""
        }
        return string(forKey: UserDefaultsKeys.mapKey.rawValue)!
    }
    
    func setCurrency(value: String)
    {
        set(value, forKey: UserDefaultsKeys.currency.rawValue)
    }
    
    func getCurrency() -> String
    {
        guard string(forKey: UserDefaultsKeys.currency.rawValue) != nil  else {
            return ""
        }
        return string(forKey: UserDefaultsKeys.currency.rawValue)!
    }
    
    func setCountryCode(value: String)
    {
        set(value, forKey: UserDefaultsKeys.CountryCode.rawValue)
    }
    
    func getCountryCode() -> String
    {
        guard string(forKey: UserDefaultsKeys.CountryCode.rawValue) != nil  else {
            return ""
        }
        return string(forKey: UserDefaultsKeys.CountryCode.rawValue)!
    }
    
    func setOTPOrPassword(value: String)
    {
        set(value, forKey: UserDefaultsKeys.isOTPOrPassword.rawValue)
    }
    
    func getOTPOrPassword() -> String
    {
        guard string(forKey: UserDefaultsKeys.isOTPOrPassword.rawValue) != nil  else {
            return ""
        }
        return string(forKey: UserDefaultsKeys.currency.rawValue)!
    }
    
    func setCurrentaddressId(value: String)
    {
        set(value, forKey: UserDefaultsKeys.currentAddressId.rawValue)
    }
    
    func getCurrentaddressId() -> String {
        
        return string(forKey: UserDefaultsKeys.currentAddressId.rawValue)!
    }
    
    func getSignUpDetails() -> [SignupField]?
    {
        let signUpData = UserDefaults.standard.data(forKey: "signUpFieldData")
        if signUpData != nil{
            let signUpArray = try! JSONDecoder().decode([SignupField].self, from: signUpData!)
            return signUpArray
        }
        else{
            return nil
        }
    }
    
    func setSignUpDetails(value: [SignupField])
    {
        let signUpData = try! JSONEncoder().encode(value)
        UserDefaults.standard.set(signUpData, forKey: "signUpFieldData")
    }
    
}


enum UserDefaultsKeys : String
{
    case isLoggedIn
    case userName
    case userID
    case accessToken
    case emailID
    case mobileNo
    case termsURL
    case mapKey
    case currentAddressId
    case currency
    case status
    case deviceToken
    case isOTPOrPassword
    case CountryCode
}




