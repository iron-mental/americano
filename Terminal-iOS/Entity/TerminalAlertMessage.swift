//
//  TerminalAlertMessage.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/06.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

enum AlertType {
    //신청
    case StudyApplyView
    //신청취소
    case StudyApplyDeleteView
    //이메일auth
    case EmailAuthView
    //방장위임
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
    static var alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
    
    class func show(controller: UIViewController, type: AlertType) {
        TerminalAlertMessage.alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        TerminalAlertMessage.alert.view.backgroundColor = .appColor(.terminalBackground)
        TerminalAlertMessage.alert.view.layer.cornerRadius = 5
        
        let contentViewController = UIViewController()
        //type = .apply
        contentViewController.view = type.view
        TerminalAlertMessage.alert.setValue(contentViewController, forKey: "contentViewController")
        
        contentViewController.view.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: TerminalAlertMessage.alert.view.topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: TerminalAlertMessage.alert.view.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: TerminalAlertMessage.alert.view.trailingAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: TerminalAlertMessage.alert.view.bottomAnchor).isActive = true
        }
        
        TerminalAlertMessage.alert.view.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.heightAnchor.constraint(equalToConstant: 250).isActive = true
        }
        
        controller.present(TerminalAlertMessage.alert, animated: true)
        ((TerminalAlertMessage.alert.value(forKey: "contentViewController") as! UIViewController).view as! AlertBaseUIView).dismissButton.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        
    }
    
    @objc class func dismiss() {
        TerminalAlertMessage.alert.dismiss(animated: true, completion: nil)
        
        ((TerminalAlertMessage.alert.value(forKey: "contentViewController") as! UIViewController).view as! AlertBaseUIView).completeButton.removeTarget(nil, action: nil, for: .allEvents)
    }
}
