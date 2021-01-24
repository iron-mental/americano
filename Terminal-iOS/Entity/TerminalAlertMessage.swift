//
//  TerminalAlertMessage.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/06.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

enum AlertType {
    case StudyApplyView
    case StudyApplyDeleteView
    case EmailAuthView
    case DelegateHostConfirmView
    
    var view: UIView {
        switch self {
        case .StudyApplyView:
            return StudyApplyMessageView(type: .apply)
        case .StudyApplyDeleteView:
            return AlertMessageView(message: "cancel your apply?")
        case .EmailAuthView:
            return EmailAlertMessageView(message: "이메일 인증하시겠습니까?\n\n 회원님의 이메일로 인증요청 됩니다.")
        case .DelegateHostConfirmView:
            return AlertMessageView(message: "방장을 위임하시겠습니까?")
        }
    }
}

class TerminalAlertMessage: NSObject {
    private static let sharedInstance = TerminalAlertMessage()
    private var backgroundView: UIView?
    static var alertView: UIView?
    
    class func show(type: AlertType) {
        
        let backgroundView = UIView()
        let alertView = type.view
        
        if let window = UIApplication.shared.windows.first {
            window.addSubview(backgroundView)
            window.addSubview(alertView)
            window.backgroundColor = UIColor.appColor(.terminalBackground)
            alertView.frame = CGRect(x: 0, y: 0, width: window.frame.maxX * 0.8, height: 300)
            backgroundView.frame = CGRect(x: 0, y: 0, width: window.frame.maxX, height: window.frame.maxY)
            backgroundView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.9)
            alertView.center = window.center
            
            sharedInstance.backgroundView?.removeFromSuperview()
            TerminalAlertMessage.alertView?.removeFromSuperview()
            sharedInstance.backgroundView = backgroundView
            TerminalAlertMessage.alertView = alertView
            
            (alertView as! AlertBaseUIView).dismissButton.addTarget(self, action: #selector(hide), for: .touchUpInside)
        }
    }
    
    @objc class func hide() {
        
        if let alertView = TerminalAlertMessage.alertView,
           let backgroundView = sharedInstance.backgroundView {
            backgroundView.removeFromSuperview()
            alertView.removeFromSuperview()
        }
    }
}
