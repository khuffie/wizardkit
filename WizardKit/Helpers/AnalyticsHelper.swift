//
//  AnalyticsHelper.swift
//  WizardKit
//
//  Created by Ahmed El-Khuffash on 2025-10-19.
//  Copyright © 2025 Ahmed El-Khuffash. All rights reserved.
//
import FirebaseAnalytics

public class AnalyticsHelper {
    
    
    static public  let shared = AnalyticsHelper()
    
    
    public func trackPageView(_ page:String, section:String) {
        
        Analytics.logEvent(AnalyticsEventScreenView,
                           parameters: [AnalyticsParameterScreenName: page,
                                        AnalyticsParameterScreenClass: section])
    }
    
    
    public func trackEvent(event: String, parameters: [String: Any]) {
        
        Analytics.logEvent(event, parameters: parameters)
    }
    
    func updateUserProperties() {
        //print("################################### UPDATE USER PROPERTIES AAAAH ######")
        //print ( UserSettings.permissions.pro.description)
        
//        Analytics.setUserProperty(UserSettings.permissions.pro.description, forName: "isPro")
//        Analytics.setUserProperty(UserSettings.permissions.weather.description, forName: "weatherSubscribed")

    }
}
