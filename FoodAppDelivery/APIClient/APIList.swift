//
//  APIList.swift
//  FoodAppDelivery
//
//  Created by Pyramidions on 08/02/19.
//  Copyright © 2019 Pyramidions. All rights reserved.
//

import Foundation
import UIKit

struct APIList
{
    let BASE_URL = "http://52.14.69.87/foodapp/public/deliveryBoy/"
    
    func getUrlString(url: urlString) -> String
    {
        return BASE_URL + url.rawValue
    }
}


enum urlString: String
{
    case SIGNUPFIELDS = "getSignupFields"
    case SIGNUPFIELDVALIDATION = "staffSignupValidation"
    case SIGNUP = "staffSignup"
    case LOGINSETTING = "getLoginSetting"
    case CHECKAVAILABILITY = "checkAvailability"
    case STAFFOTPLOGIN = "staffOtpLogin"
    case RESENDOTP = "resendOtp"
    case FORGETPASSWORD = "forgotPassword"
    case LOGIN = "staffPasswordLogin"
    case OTPVERIFICATION = "otpVerification"
    case CHANGEPASSWORD = "changePassword"
    case HOMEPAGE = "homePage"
    case UPDATETRIPSTATUS = "updateTripStatus"
    case LISTPASTORDERS = "listPastOrders"
    case GETORDER = "getOrder"
    case GETASSIGNORDER = "getAssignedOrder"
    case ACCEPTORDER = "acceptOrder"
    case REJECTORDER = "rejectedOrder"
    case VIEWORDER = "viewOrder"
    case PICKUPORDER = "pickedupOrder"
    case ORDERDELIVERED = "deliveredOrder"
    case GETPROFILE = "getProfile"
    case STATICPAGE = "getStaticpages"
    case UPDATEDEVICETOKEN = "updateDeviceToken"
    
}
