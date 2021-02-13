//
//  Constant+LocationManager.swift
//  FoodAppDelivery
//
//  Created by Pyramidions on 15/02/19.
//  Copyright © 2019 Pyramidions. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

protocol LocationServiceDelegate
{
    func tracingLocation(currentLocation: CLLocation)
    func tracingLocationDidFailWithError(error: NSError)
}

class LocationManager: NSObject,CLLocationManagerDelegate
{
    var locationManager: CLLocationManager?
    var lastLocation: CLLocation?
    var delegate: LocationServiceDelegate?
    
    override init()
    {
        super.init()
        self.locationManager = CLLocationManager()
        
        guard let locationManagers=self.locationManager else
        {
            return
        }
        
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManagers.requestAlwaysAuthorization()
            locationManagers.requestWhenInUseAuthorization()
        }
        if #available(iOS 9.0, *) {
            //            locationManagers.allowsBackgroundLocationUpdates = true
        } else {
            // Fallback on earlier versions
        }
        locationManagers.desiredAccuracy = kCLLocationAccuracyBest
        locationManagers.pausesLocationUpdatesAutomatically = false
        locationManagers.distanceFilter = 0.1
        locationManagers.delegate = self
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
       
        guard let location = locations.last else {
            return
        }
        self.lastLocation = location
        
            let locationArray = locations as NSArray
            let locationObj = locationArray.lastObject as! CLLocation
            let coord = locationObj.coordinate
            let currentLatitude = String(coord.latitude)
            let currentLongitude = String(coord.longitude)
        
            let oldLatitude = UserDefaults.standard.double(forKey: "lastKnownLatitude")
            let oldLongitude = UserDefaults.standard.double(forKey: "lastKnownLongitude")
                        
            let oldLocation : CLLocation = CLLocation.init(latitude: oldLatitude, longitude: oldLongitude)
            
            let meters: CLLocationDistance = locationObj.distance(from: oldLocation)
            print(meters)
        
            if(meters > 5){
        
                let isLoggedIn = UserDefaults.standard.isLoggedIn()
                if(isLoggedIn)
                {
//                //send current lat and lon to server
//            }
//            else{
//
//            }
                    UserDefaults.standard.set(currentLatitude, forKey: "lastKnownLatitude")
                    UserDefaults.standard.set(currentLongitude, forKey: "lastKnownLongitude")
        
                    updateLocation(currentLocation: location)
                }
            }
        
    }
    
    @nonobjc func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus)
    {
        switch status {
        case .notDetermined:
            locationManager?.requestAlwaysAuthorization()
            break
        case .authorizedWhenInUse:
            locationManager?.startUpdatingLocation()
            break
        case .authorizedAlways:
            locationManager?.startUpdatingLocation()
            break
        case .restricted:
            // restricted by e.g. parental controls. User can't enable Location Services
            break
        case .denied:
            // user denied your app access to Location Services, but can grant access from Settings.app
            break
        default:
            break
        }
    }
    
    private func updateLocation(currentLocation: CLLocation){
        
        guard let delegate = self.delegate else {
            return
        }
        
        delegate.tracingLocation(currentLocation: currentLocation)
    }
    
    private func updateLocationDidFailWithError(error: NSError) {
        
        guard let delegate = self.delegate else {
            return
        }
        
        delegate.tracingLocationDidFailWithError(error: error)
    }
    
    func startUpdatingLocation() {
        self.locationManager?.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        self.locationManager?.stopUpdatingLocation()
    }
    
    func startMonitoringSignificantLocationChanges() {
        self.locationManager?.startMonitoringSignificantLocationChanges()
    }
    
}
