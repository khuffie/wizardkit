//
//  LocationService.swift
//  tdotwiz
//
//  Created by Ahmed El-Khuffash on 2020-06-07.
//  Copyright © 2020 Ahmed El-Khuffash. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit
import Contacts


public class LocationHelper: NSObject, ObservableObject,  CLLocationManagerDelegate{
	
	public static let shared = LocationHelper()

	public var userLocation:CLLocation?
    @Published public var userAddress:String = ""
    @Published public var city:String? = ""
    @Published public var neighbourhood:String? = ""
    @Published public var country:String? = ""

	public var locationManager:CLLocationManager = CLLocationManager()

	@Published public var isLocationAvailable: Bool
	
	public var delegate: LocationHelperDelegate?
	
	public var locationCompletionHandler: (() -> Void)?
	
	
	var completion: (() -> Void)?
	
	override public init() {
		isLocationAvailable = false

		//we want the best accuracy
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		super.init()

		locationManager.delegate = self
		locationManager.startMonitoringSignificantLocationChanges()
		self.userLocation = locationManager.location
        
        //fake the location
       // self.userLocation = CLLocation(latitude: 64.68, longitude: -163.40)

        
        if self.userLocation != nil {
            self.getAddress()
        }
		
		switch locationManager.authorizationStatus {
		case .restricted, .denied, .notDetermined:
			isLocationAvailable = false
		case .authorizedWhenInUse, .authorizedAlways:
			isLocationAvailable =  true
		@unknown default:
			isLocationAvailable =  false
		}

		
	}
	
	public func requestLocationPermission( completion: @escaping () -> Void ) {
		//print("LocationHelper.requestLocationPermission")
		self.completion = completion
		
		switch locationManager.authorizationStatus {
		case .restricted, .denied:
			//let appDelegate = UIApplication.shared.delegate as! AppDelegate
			//appDelegate.showLocationServicesAlert()
			RootAlerter.shared.showLocationServicesAlert()
			return
		case .notDetermined:
			self.locationManager.requestAlwaysAuthorization()
			
			return
		case .authorizedWhenInUse, .authorizedAlways:
			//print("LocationHelper.requestLocationPermission authorizedWhenInUse authorizedAlways")
			return
		@unknown default:
			print("LocationHelper.requestLocationPermission unknown")

			break
		}
	}
	
	public func getUserLocation(completion: @escaping () -> Void) {
        print("WizardKit.LocationHelper.getUserLocation")
        locationCompletionHandler = completion
		locationManager.requestLocation()
        
	}
    

	
	public func checkIfLocationAvailable() -> Bool {
		//print("WizardKit.LocationHelper.checkIfLocationAvailable \(CLLocationManager.authorizationStatus())")
		switch locationManager.authorizationStatus {
		case .restricted, .denied, .notDetermined:
			return false
		case .authorizedWhenInUse, .authorizedAlways:
			locationManager.requestLocation() //get the user's location if authorization changed
			return true
		@unknown default:
			return false
		}
	}
	
	public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		self.isLocationAvailable = self.checkIfLocationAvailable()
		//print("WizardKit.LocationHelper.didChangeAuthorization \(self.isLocationAvailable) ")
		
		if completion != nil {
			DispatchQueue.main.async {
				self.completion!()
			}
		}
		
	}
	
	public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		//print("WizardKit.LocationHelper.didUpdateLocations")
		self.userLocation = locations.last
        
        //fake the location
        //self.userLocation = CLLocation(latitude: 64.68, longitude: -163.40)
        
        self.getAddress()
            

	}
	

    public func handleLocationUpdateCompletion() {
        if(locationCompletionHandler != nil) {
            
            let completion = self.locationCompletionHandler!
            self.locationCompletionHandler = nil
            DispatchQueue.main.async {
                completion()
            }
            
        }

    }

	public func getAddress()  {
		//userAddress = ""
		
        let ceo: CLGeocoder = CLGeocoder()



		ceo.reverseGeocodeLocation(self.userLocation!, completionHandler:
			{(placemarks, error) in
				if (error != nil)
				{
					print("WizardKit.reverse geodcode fail: \(error!.localizedDescription)")
                    self.handleLocationUpdateCompletion()
                    return  
				}
				let pm = placemarks! as [CLPlacemark]

				if pm.count > 0 {
					let pm = placemarks![0]
                    
//					print(pm.country)
//					print(pm.locality)
//					print(pm.subLocality)
//					print(pm.thoroughfare)
//					print(pm.postalCode)
//					print(pm.subThoroughfare)
//					print(pm.postalAddress!.street)
					
					self.userAddress = pm.postalAddress!.street
                    self.city = pm.locality
                    self.neighbourhood = pm.subLocality
                    self.country = pm.country
                    self.handleLocationUpdateCompletion()

			  }
		})
    

	}


	
	public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		print("WizardKit.LocationHelper.locationManager.didFailWithError \(error)")
	}

}

