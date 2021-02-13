//
//  AccountDataModel.swift
//  FoodAppDelivery
//
//  Created by Pyramidions on 22/02/19.
//  Copyright © 2019 Pyramidions. All rights reserved.
//

import Foundation
import Alamofire

class AccountDataModel: NSObject {
    
    let sharedInstance = Connection()
    weak var delegate : OrderDetailsDelegate?
    
    func requestToGetProfileData(success:@escaping (GetProfileModel) -> Void, failure:@escaping (Error) -> Void)
    {
        let url =  APIList().getUrlString(url: .GETPROFILE)
        
        let headers : HTTPHeaders = [
            "Accept":"application/json",
            "Authorization":UserDefaults.standard.getAccessToken()
        ]
        
        sharedInstance.requestGET(url, params: nil, headers: headers, success:
            {
                (JSON) in
                
                let  result :Data? = JSON
                
                if result != nil
                {
                    do
                    {
                        let response = try JSONDecoder().decode(GetProfileModel.self, from: result!)
                        success(response)
                        print("GetResponse",response)
                    }
                    catch let error as NSError
                    {
                        failure(error)
                    }
                }
                
        },
                                  failure:
            {
                (Error) in
                failure(Error)
        })
}
    
    
    func requestToGetStatic(success:@escaping (HelpDataModel) -> Void, failure:@escaping (Error) -> Void)
    {
        let url =  APIList().getUrlString(url: .STATICPAGE)
        
        sharedInstance.requestGET(url, params: nil, headers: nil, success:
            {
                (JSON) in
                
                let  result :Data? = JSON
                
                if result != nil
                {
                    do
                    {
                        let response = try JSONDecoder().decode(HelpDataModel.self, from: result!)
                        success(response)
                        print("GetResponse",response)
                    }
                    catch let error as NSError
                    {
                        failure(error)
                    }
                }
                
        },
                                  failure:
            {
                (Error) in
                failure(Error)
        })
    }
    
}

