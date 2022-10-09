//
//  EmailHelper.swift
//  WizardKit
//
//  Created by Ahmed El-Khuffash on 2021-01-14.
//  Copyright © 2021 Ahmed El-Khuffash. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI
import MessageUI

//from https://stackoverflow.com/questions/56784722/swiftui-send-email

public class EmailHelper: NSObject, MFMailComposeViewControllerDelegate {
    public static let shared = EmailHelper()
    private override init() {
        //
    }
    
    
    
    public func sendEmail(subject:String, body:String, to:String){
        if !MFMailComposeViewController.canSendMail() {
            print("No mail account found")
            
            return //EXIT
        }
        
        let picker = MFMailComposeViewController()
        
        picker.setSubject(subject)
        picker.setMessageBody(body, isHTML: true)
        picker.setToRecipients([to])
        picker.mailComposeDelegate = self
        
        EmailHelper.getRootViewController()?.present(picker, animated: true, completion: nil)
    }
    
   public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        EmailHelper.getRootViewController()?.dismiss(animated: true, completion: nil)
    }
    
   public static func getRootViewController() -> UIViewController? {
       // (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.rootViewController
       
       let scenes = UIApplication.shared.connectedScenes
       let windowScene = scenes.first as? UIWindowScene
       let window = windowScene?.windows.first
       return window?.rootViewController
       
    }
}
