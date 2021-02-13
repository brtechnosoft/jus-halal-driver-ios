//
//  CredentialsViewModel.swift
//  FoodAppDelivery
//
//  Created by Pyramidions on 08/02/19.
//  Copyright © 2019 Pyramidions. All rights reserved.
//

import Foundation
import Alamofire

class CredentialsViewModel: NSObject {
    
    let sharedInstance = Connection()

    func requestData(success:@escaping (LoginSetting) -> Void, failure:@escaping (Error) -> Void)
    {
        let url =  APIList().getUrlString(url: .LOGINSETTING)

        sharedInstance.requestGET(url, params: nil, headers: nil, success:
            {
                (JSON) in
                
                let  result :Data? = JSON
                
                if result != nil
                {
                    do
                    {
                        let response = try JSONDecoder().decode(LoginSetting.self, from: result!)
                        success(response)
                        print("GetResponse",response)
                    }
                    catch let error as NSError
                    {
                        failure(error)
                    }
                }
                else
                {
                    
                }
                
        },
                                  failure:
            {
                (Error) in
                failure(Error)
        })
    }
    
    func requestToCheckAvailability(phoneNumber:String, countryCode:String, success:@escaping (CheckAvailability) -> Void, failure:@escaping (Error) -> Void)
    {
        
        let URL = APIList().getUrlString(url: .CHECKAVAILABILITY)

        let parameter : Parameters = [
            "mobileNumber": phoneNumber,
            "countryCode": countryCode
        ]
        
        sharedInstance.requestPOST(URL, params: parameter, headers:  nil, success:
          
            {
                (JSON) in
                
                let  result :Data? = JSON
                
                if result != nil
                {
                    do
                    {
                        let response = try JSONDecoder().decode(CheckAvailability.self, from: result!)
                        success(response)
                    }
                    catch let error as NSError
                    {
                        failure(error)
                    }
                }
                else
                {
                    
                }
                
        },
                                   failure:
            {
                (Error) in
                failure(Error)
        })
    }
    
    
    func requestStaffOTPLogin(phoneNumber:String, countryCode:String, OTP:String, success:@escaping (OTPLogin) -> Void, failure:@escaping (Error) -> Void)
    {
        
        let deviceID = getDeviceID()
        
        let params: Parameters = [
            "mobileNumber": phoneNumber,
            "countryCode": countryCode,
            "otpNumber" : OTP,
            "udId" : deviceID
        ]
        
        let URL = APIList().getUrlString(url: .STAFFOTPLOGIN)
        
        sharedInstance.requestPOST(URL, params: params, headers: nil, success:
            {
                (JSON) in
                
                let  result :Data? = JSON
                
                if result != nil
                {
                    do
                    {
                        let response = try JSONDecoder().decode(OTPLogin.self, from: result!)
                        success(response)
                    }
                    catch let error as NSError
                    {
                        failure(error)
                    }
                }
                else
                {
                    
                }
        },
                                   failure:
            {
                (Error) in
                failure(Error)
        })
    }
    
    
    func requestResendOTP(phoneNo :String, countryCode :String,success:@escaping (ResendOTP) -> Void, failure:@escaping (Error) -> Void)
    {
        
        let params: Parameters = [
            "mobileNumber": phoneNo,
            "countryCode": countryCode,
            ]
        
        let URL = APIList().getUrlString(url: .RESENDOTP)
        
        sharedInstance.requestPOST(URL, params: params, headers: nil, success:
            {
                (JSON) in
                
                let  result :Data? = JSON
                
                if result != nil
                {
                    do
                    {
                        let response = try JSONDecoder().decode(ResendOTP.self, from: result!)
                        success(response)
                    }
                    catch let error as NSError
                    {
                        failure(error)
                    }
                }
                else
                {
                    
                }
        },
                                   failure:
            {
                (Error) in
                failure(Error)
        })
    }
    
    
    func requestForgetData(phoneNumber: String, phoneCountryCode: String, success:@escaping (ForgetPassword) -> Void, failure:@escaping (Error) -> Void)
    {
        
        let params: Parameters = [
            "mobileNumber": phoneNumber,
            "countryCode": phoneCountryCode
        ]
        
        let URL = APIList().getUrlString(url: .FORGETPASSWORD)
        
        sharedInstance.requestPOST(URL, params: params, headers: nil, success:
            {
                (JSON) in
                
                let  result :Data? = JSON
                
                if result != nil
                {
                    do
                    {
                        let response = try JSONDecoder().decode(ForgetPassword.self, from: result!)
                        success(response)
                    }
                    catch let error as NSError
                    {
                        failure(error)
                    }
                }
                else
                {
                    
                }
        },
                                   failure:
            {
                (Error) in
                failure(Error)
        })
    }
    
    func requestToLoginByPassword(PhoneNo :String, countryCode :String, password: String, success:@escaping (OTPLogin) -> Void, failure:@escaping (Error) -> Void)
    {
        
        let deviceID = getDeviceID()
        
        let params: Parameters = [
            "mobileNumber": PhoneNo,
            "password": password,
            "countryCode": countryCode,
            "udId":deviceID
        ]
        
        let URL = APIList().getUrlString(url: .LOGIN)

        sharedInstance.requestPOST(URL, params: params, headers: nil, success:
            {
                (JSON) in
                
                let  result :Data? = JSON
                
                if result != nil
                {
                    do
                    {
                        let response = try JSONDecoder().decode(OTPLogin.self, from: result!)
                        success(response)
                    }
                    catch let error as NSError
                    {
                        failure(error)
                    }
                }
                else
                {
                    
                }
        },
                                   failure:
            {
                (Error) in
                failure(Error)
        })
    }
    
    func requestToVertifyAnOTP(phoneNo: String,phoneCountrycode: String, otp: String, success:@escaping (OtpVerification) -> Void, failure:@escaping (Error) -> Void)
    {
        
        let params: Parameters = [
            "mobileNumber": phoneNo,
            "countryCode" : phoneCountrycode,
            "otpNumber":otp,
            ]
        
        
        let URL = APIList().getUrlString(url: .OTPVERIFICATION)
        
        sharedInstance.requestPOST(URL, params: params, headers: nil, success:
            {
                (JSON) in
                
                let  result :Data? = JSON
                
                if result != nil
                {
                    do
                    {
                        let response = try JSONDecoder().decode(OtpVerification.self, from: result!)
                        success(response)
                    }
                    catch let error as NSError
                    {
                        failure(error)
                    }
                }
                else
                {
                    
                }
        },
                                   failure:
            {
                (Error) in
                failure(Error)
        })
    }
    
    func requestPasswordChangeData(phoneNo :String, phoneCountrycode :String, OTP: String, Password: String,success:@escaping (ChangePassword) -> Void, failure:@escaping (Error) -> Void)
    {
       
        let params: Parameters = [
            "mobileNumber": phoneNo,
            "countryCode" : phoneCountrycode,
            "password":Password,
            "otpNumber": OTP
        ]
        
        
        let URL = APIList().getUrlString(url: .CHANGEPASSWORD)
        
        sharedInstance.requestPOST(URL, params: params, headers: nil, success:
            {
                (JSON) in
                
                let  result :Data? = JSON
                
                if result != nil
                {
                    do
                    {
                        let response = try JSONDecoder().decode(ChangePassword.self, from: result!)
                        success(response)
                    }
                    catch let error as NSError
                    {
                        failure(error)
                    }
                }
                else
                {
                    
                }
        },
                                   failure:
            {
                (Error) in
                failure(Error)
        })
    }
    
}
