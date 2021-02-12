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
    //신청 취소
    case StudyApplyDeleteView
    //이메일 auth
    case EmailAuthView
    //방장 위임
    case DelegateHostConfirmView
    //스터디 나가기
    case LeaveStudyView
    //스터디 삭제
    case DeleteStudyView
    //프로젝트 3개 이하 안내
    case ProjectLimitView
    
    var view: UIView {
        switch self {
        case .StudyApplyView:
            return StudyApplyMessageView(type: .apply)
        case .StudyApplyDeleteView:
            return AlertMessageView(message: "cancel your apply?")
        case .EmailAuthView:
            //이부분 AlertMessageView 안쓰고 따로 만든 이유가 있는지?
            return EmailAlertMessageView(message: "이메일 인증하시겠습니까?\n\n 회원님의 이메일로 인증요청 됩니다.")
        case .DelegateHostConfirmView:
            return AlertMessageView(message: "방장을 위임하시겠습니까?")
        case .LeaveStudyView:
            let leaveStudyView = AlertMessageView(message: "스터디를 나가시겠습니까?")
            leaveStudyView.alertMessageLabel.textColor = .systemRed
            return leaveStudyView
        case .DeleteStudyView:
            let deleteStudyView = AlertMessageView(message: "스터디를 삭제하시겠습니까?")
            deleteStudyView.alertMessageLabel.textColor = .systemRed
            return deleteStudyView
        case .ProjectLimitView:
            let projectLimitView = AlertMessageView(message: "작성 가능한 프로젝트는 최대 3개입니다.")
            projectLimitView.alertMessageLabel.font = UIFont.monospacedSystemFont(ofSize: projectLimitView.alertMessageLabel.font.pointSize - 3, weight: UIFont.Weight.regular)
            projectLimitView.onlyCompleteButton()
            return projectLimitView
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
        TerminalAlertMessage.alert.view.layer.cornerRadius = 15
        
        let contentViewController = UIViewController()
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
        if let contentViewController = TerminalAlertMessage.alert.value(forKey: "contentViewController") {
            if let castContentViewController = contentViewController as? UIViewController {
                if let alertView = castContentViewController.view as? AlertBaseUIView {
                    alertView.dismissButton.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
                }
            }
        }
        
    }
    
    class func getAlertCompleteButton() -> UIButton {
        var completeButton = UIButton()
        if let contentViewController = TerminalAlertMessage.alert.value(forKey: "contentViewController") {
            if let castContentViewController = contentViewController as? UIViewController {
                if let alertView = castContentViewController.view as? AlertBaseUIView {
                    completeButton = alertView.completeButton
                }
            }
        }
        return completeButton
    }
    
    @objc class func dismiss(_ sender: UIButton? = nil) {
        
        TerminalAlertMessage.alert.dismiss(animated: true, completion: nil)
        if let contentViewController = TerminalAlertMessage.alert.value(forKey: "contentViewController") {
            if let castContentViewController = contentViewController as? UIViewController {
                if let alertView = castContentViewController.view as? AlertBaseUIView {
                    alertView.completeButton.removeTarget(nil, action: nil, for: .allEvents)
                }
            }
        }
    }
}
