//
//  Constant+Helper.swift
//  FoodAppDelivery
//
//  Created by Pyramidions on 11/02/19.
//  Copyright © 2019 Pyramidions. All rights reserved.
//

import Foundation
import Alamofire
import SDWebImage
import CoreLocation


let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height
let screenFrame = CGRect(x: 0.0, y: 0.0, width: screenWidth, height: screenHeight)

class ImageLoader
{
    func imageLoad(imgView :UIImageView,url :String)
    {
        imgView.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "placeholder"))
    }
}

class Connectivity
{
    class func isConnectedToInternet() ->Bool
    {
        return NetworkReachabilityManager()!.isReachable
    }
}

class Location
{
    class func isLocationEnabled() ->Bool
    {
        if CLLocationManager.locationServicesEnabled()
        {
            switch CLLocationManager.authorizationStatus()
            {
            case .notDetermined, .restricted, .denied:
                print("No access")
                return false
            case .authorizedAlways, .authorizedWhenInUse:
                print("Access")
                return true
            }
        }
        else
        {
            print("Location services are not enabled")
            return false
        }
    }
}

class FBShimmer
{
    var shimmeringView = FBShimmeringView()

    func loadanimatingView(frame : CGRect, view : UIView)
    {
        shimmeringView.subviews.forEach { $0.removeFromSuperview() }
        shimmeringView.removeFromSuperview()
        
        shimmeringView.isShimmering = true
        shimmeringView.shimmeringBeginFadeDuration = 0.2
        shimmeringView.shimmeringOpacity = 0.2
        shimmeringView.shimmeringSpeed = 280
        shimmeringView.frame = frame
        shimmeringView.backgroundColor = UIColor.white
        view.addSubview(shimmeringView)
        
        let loadingView = UIView()
        loadingView.backgroundColor = UIColor.clear
        loadingView.frame = shimmeringView.bounds
        shimmeringView.contentView = loadingView;
        
        var count = CGFloat()
        count = frame.size.height/90
        count = round(count)
        
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.frame = CGRect(x: CGFloat(0.0), y: CGFloat(20), width: CGFloat(screenWidth), height: CGFloat(200))
        loadingView.addSubview(view)
        
        let view1 = UIView()
        view1.backgroundColor = UIColor(hexString:"#DCDCDC")     //UIColor.darkGray
        view1.frame = CGRect(x: CGFloat(15.0), y: CGFloat(10.0), width: CGFloat(view.frame.size.width-30.0), height: CGFloat(200))
        view1.layer.cornerRadius = 5.0
        view1.layer.masksToBounds = true
        view.addSubview(view1)
        
        for i in 0 ..< Int(count) - 1
        {
            let view = UIView()
            view.backgroundColor = UIColor.clear
            view.frame = CGRect(x: CGFloat(0.0), y: CGFloat(250 + (i * 200)), width: CGFloat(screenWidth), height: CGFloat(200.0))
            loadingView.addSubview(view)
            
            let view1 = UIView()
            view1.backgroundColor = UIColor(hexString:"#DCDCDC")
            view1.frame = CGRect(x: CGFloat(15.0), y: CGFloat(50.0), width: CGFloat(view.frame.size.width-30.0), height: CGFloat(200))
            view1.layer.cornerRadius = 5.0
            view1.layer.masksToBounds = true
            view.addSubview(view1)
        }
    }
    
    func stopanimatingView()
    {
        shimmeringView.subviews.forEach { $0.removeFromSuperview() }
        shimmeringView.removeFromSuperview()
    }
}
