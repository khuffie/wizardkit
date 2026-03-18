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
import MapKit


public class LocationHelper: NSObject, ObservableObject,  CLLocationManagerDelegate{
	
	public static let shared = LocationHelper()

	public var userLocation:CLLocation?
    @Published public var userAddress:String = ""
    @Published public var city:String? = ""
    @Published public var neighbourhood:String? = ""
    @Published public var country:String? = ""

	public var locationManager:CLLocationManager = CLLocationManager()

	@Published public var isLocationAvailable: Bool
	
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
			UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
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
		print("LocationHelper.getAddress")

		guard let request = MKReverseGeocodingRequest(location: self.userLocation!) else {
			self.handleLocationUpdateCompletion()
			return
		}
		request.getMapItems { mapItems, error in
			if let error = error {
				print("WizardKit.reverse geodcode fail: \(error.localizedDescription)")
				self.handleLocationUpdateCompletion()
				return
			}
			if let mapItem = mapItems?.first {
				self.userAddress = mapItem.address?.shortAddress ?? ""
				self.city = mapItem.addressRepresentations?.cityName
				self.neighbourhood = mapItem.name
				self.country = mapItem.addressRepresentations?.regionName
				self.handleLocationUpdateCompletion()
			}
		}

	}


	
	public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		print("WizardKit.LocationHelper.locationManager.didFailWithError \(error)")
	}

}

