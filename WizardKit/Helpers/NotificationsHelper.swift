//
//  NotificationsHelper.swift
//  tdotwiz
//
//  Created by Ahmed El-Khuffash on 2020-06-09.
//  Copyright © 2020 Ahmed El-Khuffash. All rights reserved.
//

import Foundation
import UserNotifications
import UIKit

public class NotificationsHelper: NSObject, ObservableObject {
	
	public static let shared = NotificationsHelper()
	
	var nc = UNUserNotificationCenter.current()
	@Published public var areNotificationAvailable: Bool

	override private init() {
		areNotificationAvailable = false
		super.init()
		self.getAuthorizationStatus()
	}
	
	/**
	determine if notifications are available on app launch
	*/
	public func getAuthorizationStatus() {
		nc.getNotificationSettings(completionHandler: { settings in
			switch settings.authorizationStatus {
			case .notDetermined, .provisional, .denied:
				self.setAuthStatus(with: false)
				return
			case .authorized:
				//print("WizardKit.NotificationsHelper.autStaths \(self.areNotificationAvailable)")
				self.setAuthStatus(with: true)
				return
			default:
				self.setAuthStatus(with: false)
				return
			}
			
		})
	}
	
	func setAuthStatus(with value:Bool) {
		DispatchQueue.main.async {
			self.areNotificationAvailable = value
		}

	}
	
	public func requestAuthorization() {
		nc.getNotificationSettings(completionHandler: { settings in
			
			switch settings.authorizationStatus {
			case .notDetermined, .provisional:
				//request authorization
				self.nc.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
					if success {
						self.setAuthStatus(with: true)
					}
				}
				return
			case .denied:
				DispatchQueue.main.async {
//					let appDelegate = UIApplication.shared.delegate as! AppDelegate
//					appDelegate.showNotificationsAlert()
					RootAlerter.shared.showNotificationsAlert()
				}
			case .authorized:
				//we already have authorization
				self.setAuthStatus(with: false)
				return
			default:
				self.setAuthStatus(with: false)
			}
		})
	}

	public func deleteNotifications(for threadIdentifier:String, completion: @escaping () -> Void) {
		
		UNUserNotificationCenter.current().getPendingNotificationRequests { notifications in
			print("WizardKit.NotificationHelper.deleteNotifications: \(notifications.count) \(threadIdentifier)")
			
			//keep track of the notifications we want to delete
			var identifiers:[String] = []
			
			for notification in notifications {
				if(notification.content.threadIdentifier == threadIdentifier) {
					identifiers.append(notification.identifier)
				}
			}
			
			//now delete them
			print("WizardKit.Deleting \(identifiers.count) notifications")
			UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: identifiers)
			
			//now continue what we are doing
			DispatchQueue.main.async {
				completion()
			}
		}
	}
	
}
