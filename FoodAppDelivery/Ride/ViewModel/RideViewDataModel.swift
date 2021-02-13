//
//  RideViewDataModel.swift
//  FoodAppDelivery
//
//  Created by Pyramidions on 16/02/19.
//  Copyright © 2019 Pyramidions. All rights reserved.
//

import Foundation
import Alamofire

protocol OrderDetailsDelegate: class {
    func didReceiveOrderDetails(response: OrderDetails)
    func didFailOrderDetails(error : Error)
}

class RideViewDataModel: NSObject {
    
    let sharedInstance = Connection()
    weak var delegate : OrderDetailsDelegate?
    
    func requestHomeDetailsData(success:@escaping (RideDetailModel) -> Void, failure:@escaping (Error) -> Void)
    {
        let url =  APIList().getUrlString(url: .HOMEPAGE)
        
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
                        let response = try JSONDecoder().decode(RideDetailModel.self, from: result!)
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
    
    func requestToUpdateStatus(status:Int,success:@escaping (StatusModel) -> Void, failure:@escaping (Error) -> Void)
    {
 
        let url =  APIList().getUrlString(url: .UPDATETRIPSTATUS)
    
        let headers : HTTPHeaders = [
            "Accept":"application/json",
            "Authorization":UserDefaults.standard.getAccessToken()
        ]
        
        let params : Parameters = [
            "tripStatus" : status
        ]
    
        sharedInstance.requestPOST(url, params: params, headers: headers, success:
        {
        (JSON) in
    
        let  result :Data? = JSON
    
        if result != nil
        {
            do
            {
                let response = try JSONDecoder().decode(StatusModel.self, from: result!)
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
    
    func requestToGetOrder(isAssignOrder:Bool, success:@escaping (GetOrderModel) -> Void, failure:@escaping (Error) -> Void)
    {
        var url : String? = ""
        if isAssignOrder
        {
            url =  APIList().getUrlString(url: .GETASSIGNORDER)
        }
        else{
             url =  APIList().getUrlString(url: .GETORDER)
        }
        
        let headers : HTTPHeaders = [
            "Accept":"application/json",
            "Authorization":UserDefaults.standard.getAccessToken()
        ]
       
        sharedInstance.requestGET(url!, params: nil, headers: headers, success:
            {
                (JSON) in
                
                let  result :Data? = JSON
                
                if result != nil
                {
                    do
                    {
                        let response = try JSONDecoder().decode(GetOrderModel.self, from: result!)
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
    
    
    func requestToAcceptOrder(isAccept: Bool, OrderID: Int, success:@escaping (StatusModel) -> Void, failure:@escaping (Error) -> Void)
    {
        var url : String? = ""

        if isAccept
        {
            url =  APIList().getUrlString(url: .ACCEPTORDER)
        }
        else{
            url = APIList().getUrlString(url: .REJECTORDER)
        }
        
        let headers : HTTPHeaders = [
            "Accept":"application/json",
            "Authorization": UserDefaults.standard.getAccessToken()
        ]
        
        let params : Parameters = [
            "orderId" : OrderID
        ]
        sharedInstance.requestPOST(url!, params: params, headers: headers, success:
            {
                (JSON) in
                
                let  result :Data? = JSON
                
                if result != nil
                {
                    do
                    {
                        let response = try JSONDecoder().decode(StatusModel.self, from: result!)
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
    
    func requestToGetOrderDetails(orderID:Int)
    {
        let url =  APIList().getUrlString(url: .VIEWORDER)
        
        let headers : HTTPHeaders = [
            "Accept":"application/json",
            "Authorization": UserDefaults.standard.getAccessToken()
        ]
        
        let params : Parameters = [
            "orderId" : orderID
        ]
        
        sharedInstance.requestPOST(url, params: params, headers: headers, success: {
            (JSON) in
            
            let  result :Data? = JSON
            
            if result != nil
            {
                do
                {
                    let response = try JSONDecoder().decode(OrdersModel.self, from: result!)
                    
                    if response.error == "false"
                    {
                        self.delegate?.didReceiveOrderDetails(response: response.orderDetails)
                    }
                    else
                    {
                        let error = NSError(domain: "", code: 4, userInfo: [NSLocalizedDescriptionKey : response.errorMessage ?? ""])
                                
                        self.delegate?.didFailOrderDetails(error: error)
                    }
                    
                }
                catch let error as NSError
                {
                    
                    self.delegate?.didFailOrderDetails(error: error)
                }
            }
            else
            {
            }
            
        }, failure:{
            
            (Error) in
            print("Error")
        })
    }
    
    
    func requestToPickOrder(OrderID: Int, urlName:String, success:@escaping (StatusModel) -> Void, failure:@escaping (Error) -> Void)
    {
        var url : String?
        
        if urlName == "0"
        {
             url =  APIList().getUrlString(url: .PICKUPORDER)
        }
        else{
             url = APIList().getUrlString(url: .ORDERDELIVERED)
        }
        
        let headers : HTTPHeaders = [
            "Accept":"application/json",
            "Authorization": UserDefaults.standard.getAccessToken()
        ]
        
        let params : Parameters = [
            "orderId" : OrderID
        ]
        
        sharedInstance.requestPOST(url!, params: params, headers: headers, success:
        {
                (JSON) in
                
                let  result :Data? = JSON
                
                if result != nil
                {
                    do
                    {
                        let response = try JSONDecoder().decode(StatusModel.self, from: result!)
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
    
    func requestToUpdateDeviceToken()
    {
        let url =  APIList().getUrlString(url: .UPDATEDEVICETOKEN)
        
        let headers : HTTPHeaders = [
            "Accept":"application/json",
            "Authorization":UserDefaults.standard.getAccessToken()
        ]
        
        let parameter : Parameters = [
            "fcmToken": UserDefaults.standard.getDeviceToken(),
            "osType":"iOS"
        ]
        
        sharedInstance.requestPOST(url, params: parameter, headers: headers, success:
            {
                (JSON) in
                
                let  result :Data? = JSON
                
                if result != nil
                {
                    do
                    {
                        let response = try JSONDecoder().decode(ChangePassword.self, from: result!)
                        print("DeviceToken Updated Successfully",response)
                    }
                    catch let error as NSError
                    {
                        print("DeviceToken Not Updated")
                        
                    }
                }
                else
                {
                }
                
        },
                                   failure:
            {
                (error) in
                
        })
    }
}


