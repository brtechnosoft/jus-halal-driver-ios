//
//  OrderDataModel.swift
//  FoodAppDelivery
//
//  Created by Pyramidions on 16/02/19.
//  Copyright © 2019 Pyramidions. All rights reserved.
//

import Foundation
import Alamofire

class OrderDataModel: NSObject {
    
    let sharedInstance = Connection()
    
    func requestToGetOrderDetailsData(success:@escaping (OrdersListModel) -> Void, failure:@escaping (Error) -> Void)
    {
        let url =  APIList().getUrlString(url: .LISTPASTORDERS)
        
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
                        let response = try JSONDecoder().decode(OrdersListModel.self, from: result!)
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
