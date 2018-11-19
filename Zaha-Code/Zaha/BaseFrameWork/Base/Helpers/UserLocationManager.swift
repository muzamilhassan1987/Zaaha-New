//
//  UserLocationManager.swift
//  Zaha
//
//  Created by Soomro Shahid on 11/18/18.
//  Copyright © 2018 Faraz Haider. All rights reserved.
//

import Foundation
import MapKit

protocol LocationUpdateProtocol {
    func locationDidUpdateToLocation(location : CLLocation)
}

/// Notification on update of location. UserInfo contains CLLocation for key "location"
let kLocationDidChangeNotification = "LocationDidChangeNotification"

class UserLocationManager: NSObject, CLLocationManagerDelegate {
    
    static let SharedManager = UserLocationManager()
    
    private var locationManager = CLLocationManager()
    
    var currentLocation : CLLocation?
    
    var delegate : LocationUpdateProtocol!
    
    private override init () {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        self.locationManager.distanceFilter = kCLLocationAccuracyHundredMeters
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    func stopUpdatingLocation() {
        self.locationManager.stopUpdatingLocation()
    }
    func startUpdatingLocation() {
        self.locationManager.startUpdatingLocation()
    }
    
    
    // MARK: - CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        currentLocation = locations[0]
        let userInfo : NSDictionary = ["location" : currentLocation!]
         self.delegate.locationDidUpdateToLocation(location: self.currentLocation!)
//        DispatchQueue.main.async(execute: { () -> Void in
//            self.delegate.locationDidUpdateToLocation(location: self.currentLocation!)
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: kLocationDidChangeNotification), object: self, userInfo: userInfo as [NSObject : AnyObject])
//        })
        
    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        currentLocation = newLocation
        
        let userInfo : NSDictionary = ["location" : currentLocation!]
        
        DispatchQueue.main.async(execute: { () -> Void in
            self.delegate.locationDidUpdateToLocation(location: self.currentLocation!)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: kLocationDidChangeNotification), object: self, userInfo: userInfo as [NSObject : AnyObject])
        })
        
//        dispatch_async(dispatch_get_main_queue()) { () -> Void in
//            self.delegate.locationDidUpdateToLocation(self.currentLocation!)
//            NSNotificationCenter.defaultCenter().postNotificationName(kLocationDidChangeNotification, object: self, userInfo: userInfo as [NSObject : AnyObject])
//        }
    }
    
}

//IMPLEMENTATION WAYS
/*
 1)
  NotificationCenter.default.addObserver(self, selector: Selector(("locationUpdateNotification")), name: NSNotification.Name(rawValue: kLocationDidChangeNotification), object: nil)
 CALL METHOD
 func locationUpdateNotification(notification: NSNotification) {
 let userinfo = notification.userInfo
 self.currentLocation = userinfo!["location"] as! CLLocation
 print("Latitude : \(self.currentLocation.coordinate.latitude)")
 print("Longitude : \(self.currentLocation.coordinate.longitude)")
 
 }
 
 2)
 let LocationMgr = UserLocationManager.SharedManager
 LocationMgr.delegate = self
 // MARK: - LocationUpdateProtocol
 
 func locationDidUpdateToLocation(location: CLLocation) {
 currentLocation = location
 print("Latitude : \(self.currentLocation.coordinate.latitude)")
 print("Longitude : \(self.currentLocation.coordinate.longitude)")
 }
 
 
 */
