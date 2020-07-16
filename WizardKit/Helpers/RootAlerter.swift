//
//  RootViewControllerAlerter.swift
//  WizardKit
//
//  Created by Ahmed El-Khuffash on 2020-06-16.
//  Copyright © 2020 Ahmed El-Khuffash. All rights reserved.
//

import Foundation
import UIKit

public class RootAlerter {
	 
	public static var shared = RootAlerter()
	
	public var rootViewController: UIViewController?
	
	private init() {
	}
	
	public func showLocationServicesAlert() {
		print("WizardKit.AppDelegate.showLocationServicesAlert")
		let alertVC = UIAlertController(title: "Location Permissions are needed" , message: "Looks like location permissions aren't enabled. Tap on Go To Settings to enable them.", preferredStyle: UIAlertController.Style.alert)
		
		let okAction = UIAlertAction(title: "Go to Settings", style: UIAlertAction.Style.cancel) { (alert) in
			UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
		}
		let cancelAction = UIAlertAction(title: "Cancel", style: .default )
		
		alertVC.addAction(okAction)
		alertVC.addAction(cancelAction)

		rootViewController?.present(alertVC, animated: true, completion: nil)
	}
	
	public func showNotificationsAlert() {
		print("WizardKit.AppDelegate.showNotificationsAlert")
		let alertVC = UIAlertController(title: "Notification Permissions are needed" , message: "Tap on Go To Settings to enable them.", preferredStyle: UIAlertController.Style.alert)
		
		let okAction = UIAlertAction(title: "Go to Settings", style: UIAlertAction.Style.cancel) { (alert) in
			UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
		}
		let cancelAction = UIAlertAction(title: "Cancel", style: .default )
		
		alertVC.addAction(okAction)
		alertVC.addAction(cancelAction)

		rootViewController?.present(alertVC, animated: true, completion: nil)
	}
}
