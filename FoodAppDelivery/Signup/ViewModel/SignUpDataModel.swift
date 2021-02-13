//
//  SignUpData.swift
//  FoodAppDelivery
//
//  Created by Pyramidions on 12/03/19.
//  Copyright © 2019 Pyramidions. All rights reserved.
//

import Foundation

class SignUpDataModel : NSObject
{
    let sharedInstance = Connection()

    func requestData(success:@escaping (SignUpModel) -> Void, failure:@escaping (Error) -> Void)
    {
        let url =  APIList().getUrlString(url: .SIGNUPFIELDS)
        
        sharedInstance.requestGET(url, params: nil, headers: nil, success:
            {
                (JSON) in
                
                let  result :Data? = JSON
                
                if result != nil
                {
                    do
                    {
                        let response = try JSONDecoder().decode(SignUpModel.self, from: result!)
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
    
    func requestToValidateData(dict: [String: Any], success:@escaping (ChangePassword) -> Void, failure:@escaping (Error) -> Void)
    {
        let url =  APIList().getUrlString(url: .SIGNUPFIELDVALIDATION)
        
        let params = dict
        
        sharedInstance.requestPOST(url, params: params, headers: nil, success:
        {
                (JSON) in
                
                let  result :Data? = JSON
                
                if result != nil
                {
                    do
                    {
                        let response = try JSONDecoder().decode(ChangePassword.self, from: result!)
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
    
    func requestToSignUpUser(dict:[String:Any], success: @escaping(ChangePassword) -> Void, failure:@escaping(Error) -> Void)
    {
        let url =  APIList().getUrlString(url: .SIGNUP)
        
        let params = dict
        
        sharedInstance.requestPOST(url, params: params, headers: nil, success:
        {
            (JSON) in
                
            let  result :Data? = JSON
                
            if result != nil
            {
                do
                {
                    let response = try JSONDecoder().decode(ChangePassword.self, from: result!)
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
}
