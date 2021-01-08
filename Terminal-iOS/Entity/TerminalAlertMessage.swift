//
//  TerminalAlertMessage.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/06.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

class TerminalAlertMessage: NSObject {
    private static let sharedInstance = TerminalAlertMessage()
    private var backgroundView: UIView?
    var alertView: TerminalAlertUIView?
    
    class func show() {
        let backgroundView = UIView()
        let alertView = TerminalAlertUIView()
        
        if let window = UIApplication.shared.keyWindow {
            window.addSubview(backgroundView)
            window.addSubview(alertView)
            window.backgroundColor = UIColor.appColor(.terminalBackground)
            alertView.frame = CGRect(x: 0, y: 0, width: window.frame.maxX * 0.8, height: 300)
            backgroundView.frame = CGRect(x: 0, y: 0, width: window.frame.maxX, height: window.frame.maxY)
            backgroundView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.9)
            alertView.center = window.center
            
            sharedInstance.backgroundView?.removeFromSuperview()
            sharedInstance.alertView?.removeFromSuperview()
            sharedInstance.backgroundView = backgroundView
            sharedInstance.alertView = alertView
        }
    }
    
    class func hide() {
        if let alertView = sharedInstance.alertView,
           let backgroundView = sharedInstance.backgroundView {
            backgroundView.removeFromSuperview()
            alertView.removeFromSuperview()
        }
    }
}
