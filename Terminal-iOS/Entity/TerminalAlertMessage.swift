//
//  TerminalAlertMessage.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/06.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

enum AlertType {
    case StudyApplyView                 //신청
    case StudyApplyDeleteView           //신청 취소
    case EmailAuthView                  //이메일 auth
    case DelegateHostConfirmView        //방장 위임
    case LeaveStudyView                 //스터디 나가기
    case DeleteStudyView                //스터디 삭제
    case ProjectLimitView               //프로젝트 3개 이하 안내
    case AllowUserView                  //스터디 신청 수락
    case RejectUserView                 //스터디 신청 거절
    case LogOutView                     //로그아웃
    case VersionUpdateRecommendView     //업데이트 권장
    case VersionUpdateRequiredView      //업데이트 필수
    case JumpToSettingAppView           //알림 설정
    case ReportContentView              //컨텐츠 신고
    case ServerMaintenanceView          //서버 점검중
    
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
        case .AllowUserView:
            let allowUserView = AlertMessageView(message: "유저의 입장을 수락하시겠습니까?")
            return allowUserView
        case .RejectUserView:
            let rejectUserView = AlertMessageView(message: "유저의 입장을 거절하시겠습니까?")
            rejectUserView.alertMessageLabel.textColor = .systemRed
            return rejectUserView
        case .LogOutView:
            let logoutView = AlertMessageView(message: "로그아웃 하시겠습니까?")
            return logoutView
        case .VersionUpdateRecommendView:
            let versionUpdateRecommendView = AlertMessageView(message: "앱이 새롭게 업데이트 되었습니다.\n업데이트 하시겠습니까?")
            versionUpdateRecommendView.completeButton.setTitle("업데이트", for: .normal)
            versionUpdateRecommendView.dismissButton.setTitle("다음에 하기", for: .normal)
            return versionUpdateRecommendView
        case .VersionUpdateRequiredView:
            let versionUpdateRequiredView = AlertMessageView(message: "앱이 새롭게 업데이트 되었습니다.\n업데이트 후 이용해주세요.")
            versionUpdateRequiredView.onlyCompleteButton()
            versionUpdateRequiredView.completeButton.setTitle("업데이트 하러 가기", for: .normal)
            return versionUpdateRequiredView
        case .JumpToSettingAppView:
            let jumpToSettingAppView = AlertMessageView(message: "터미널 앱 알림허용이 필요합니다.\niOS 알림 설정페이지로 지금\n이동하시겠습니까?")
            return jumpToSettingAppView
        case .ReportContentView:
            let reportContentView = AlertReportContentView()
            return reportContentView
        case .ServerMaintenanceView:
            let serverMaintenanceView = AlertMessageView(message: "터미널 앱이 점검중입니다.\n조금만 기다려주세요.\n확인버튼을 누르면 앱이 종료됩니다.")
            serverMaintenanceView.onlyCompleteButton()
            return serverMaintenanceView
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
                    if alertView.dismissButton.isHidden {
                        alertView.completeButton.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
                    } else {
                        alertView.dismissButton.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
                    }
                }
            }
        }
        
    }
    
    class func getLeftButton() -> UIButton {
        var button = UIButton()
        if let contentViewController = TerminalAlertMessage.alert.value(forKey: "contentViewController") {
            if let castContentViewController = contentViewController as? UIViewController {
                if let alertView = castContentViewController.view as? AlertBaseUIView {
                    button = alertView.dismissButton
                }
            }
        }
        return button
    }
    
    class func getRightButton() -> UIButton {
        var button = UIButton()
        if let contentViewController = TerminalAlertMessage.alert.value(forKey: "contentViewController") {
            if let castContentViewController = contentViewController as? UIViewController {
                if let alertView = castContentViewController.view as? AlertBaseUIView {
                    button = alertView.completeButton
                }
            }
        }
        return button
    }
    
    class func removeLeftButtonAction() {
        if let contentViewController = TerminalAlertMessage.alert.value(forKey: "contentViewController") {
            if let castContentViewController = contentViewController as? UIViewController {
                if let alertView = castContentViewController.view as? AlertBaseUIView {
                    alertView.dismissButton.removeTarget(nil, action: nil, for: .allEvents)
                }
            }
        }
    }
    
    class func removeRightButtonAction() {
        if let contentViewController = TerminalAlertMessage.alert.value(forKey: "contentViewController") {
            if let castContentViewController = contentViewController as? UIViewController {
                if let alertView = castContentViewController.view as? AlertBaseUIView {
                    alertView.completeButton.removeTarget(nil, action: nil, for: .allEvents)
                }
            }
        }
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
