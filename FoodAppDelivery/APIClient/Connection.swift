//
//  Connection.swift
//  FoodAppDelivery
//
//  Created by Pyramidions on 08/02/19.
//  Copyright © 2019 Pyramidions. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import Localize_Swift

class Connection
{
    
    func requestPOST(_ url: String, params : Parameters?, headers : HTTPHeaders?, success:@escaping (Data) -> Void, failure:@escaping (Error) -> Void)
    {
        
        print("URL = ",url)
        print("Parameter = ",params!)
        
        
        if Connectivity.isConnectedToInternet()
        {
            if headers == nil
            {
                Alamofire.request(url, method: .post, parameters: params!, encoding: JSONEncoding.default, headers: nil).responseJSON
                    {
                        (responseObject) -> Void in
                        
                        print("Response = ",responseObject)
                        
                        switch responseObject.result
                        {
                        case .success:
                            if let data = responseObject.data
                            {
                                let json = JSON(responseObject.result.value!)
                                print("JSON Response = ",json)

                                success(data)
                            }
                        case .failure(let error):
                            failure(error)
                        }
                        /* if responseObject.result.isSuccess {
                         let resJson = JSON(responseObject.result.value!)
                         success(resJson)
                         }
                         if responseObject.result.isFailure {
                         let error : Error = responseObject.result.error!
                         failure(error)
                         }*/
                }
            }
            else
            {
                
                print("Headers = ",headers!)
                
                Alamofire.request(url, method: .post, parameters: params!, encoding: JSONEncoding.default, headers: headers!).responseJSON
                    {
                        (responseObject) -> Void in
                        
                        print("Response = ",responseObject)
                        
                        switch responseObject.result
                        {
                        case .success:
                            if let data = responseObject.data
                            {
                                let json = JSON(responseObject.result.value!)
                                print("JSON Response = ",json)

                                success(data)
                            }
                        case .failure(let error):
                            failure(error)
                        }
                        /*                if responseObject.result.isSuccess {
                         let resJson = JSON(responseObject.result.value!)
                         success(resJson)
                         }
                         if responseObject.result.isFailure {
                         let error : Error = responseObject.result.error!
                         failure(error)
                         }*/
                }
            }
            
        }
        else
        {
            //            let err = NSError(domain: "Check Internet Connection".localized(), code: nil, userInfo: nil)
            let error = NSError(domain: "", code: 4, userInfo: [NSLocalizedDescriptionKey : "Check Internet Connection".localized()])
            
            failure(error)
        }
    }
    
    
    func requestGET(_ url: String, params : Parameters?,headers : [String : String]?, success:@escaping (Data) -> Void, failure:@escaping (Error) -> Void)
    {
        
        do
        {
            Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON
                {
                    (response) in
                    
                    print("Response = ",response)
                    
                    switch response.result
                    {
                    case .success:
                        if let data = response.data
                        {
                            let json = JSON(response.result.value!)
                            print("JSON Response = ",json)

                            success(data)
                        }
                    case .failure(let error):
                        failure(error)
                    }
            }
            
            
            /*
             
             Alamofire.request(URL, headers: headers).responseJSON
             {
             (responseObject) -> Void in
             
             if responseObject.result.isSuccess {
             let resJson = JSON(responseObject.result.value!)
             success(resJson)
             }
             if responseObject.result.isFailure {
             let error : Error = responseObject.result.error!
             failure(error)
             }
             }*/
            
        }
        catch let JSONError as NSError
        {
            failure(JSONError)
        }
        
    }
    
}
