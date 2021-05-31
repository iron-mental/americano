//
//  TerminalAlertMessage.swift
//  TerminalAlert
//
//  Created by once on 2021/05/31.
//

import UIKit

public enum AlertType {
  case StudyApplyView                 // 신청
  case StudyApplyDeleteView           // 신청 취소
  case EmailAuthView                  // 이메일 auth
  case DelegateHostConfirmView        // 방장 위임
  case LeaveStudyView                 // 스터디 나가기
  case DeleteStudyView                // 스터디 삭제
  case ProjectLimitView               // 프로젝트 3개 이하 안내
  case AllowUserView                  // 스터디 신청 수락
  case RejectUserView                 // 스터디 신청 거절
  case LogOutView                     // 로그아웃
  case VersionUpdateRecommendView     // 업데이트 권장
  case VersionUpdateRequiredView      // 업데이트 필수
  case JumpToSettingAppView           // 알림 설정
  case ReportContentView              // 컨텐츠 신고
  case ServerMaintenanceView          // 서버 점검중
  case LaunchDisConnectView           // 런치스크린 통신에러
  
  var view: UIView {
    switch self {
    case .StudyApplyView:
      return StudyApplyMessageView(type: .apply)
    case .StudyApplyDeleteView:
      let studyApplyDeleteView = AlertMessageView(message: "가입 신청을 취소하시겠습니까?")
      studyApplyDeleteView.dismissButton.setTitle("닫기", for: .normal)
      studyApplyDeleteView.completeButton.setTitle("신청 취소", for: .normal)
      studyApplyDeleteView.completeButton.setTitleColor(.systemRed, for: .normal)
      return studyApplyDeleteView
    case .EmailAuthView:
      return EmailAlertMessageView(message: "이메일 인증하시겠습니까?\n\n회원님의 이메일로 인증 요청됩니다.")
    case .DelegateHostConfirmView:
      return AlertMessageView(message: "방장을 위임하시겠습니까?")
    case .LeaveStudyView:
      let leaveStudyView = AlertMessageView(message: "스터디를 나가시겠습니까?")
      leaveStudyView.alertMessageLabel.textColor = .systemRed
      leaveStudyView.dismissButton.setTitle("닫기", for: .normal)
      leaveStudyView.completeButton.setTitle("나가기", for: .normal)
      leaveStudyView.completeButton.setTitleColor(.systemRed, for: .normal)
      return leaveStudyView
    case .DeleteStudyView:
      let deleteStudyView = AlertMessageView(message: "스터디를 삭제하시겠습니까?")
      deleteStudyView.alertMessageLabel.textColor = .systemRed
      deleteStudyView.dismissButton.setTitle("닫기", for: .normal)
      deleteStudyView.completeButton.setTitle("삭제하기", for: .normal)
      deleteStudyView.completeButton.setTitleColor(.systemRed, for: .normal)
      return deleteStudyView
    case .ProjectLimitView:
      let projectLimitView = AlertMessageView(message: "작성 가능한 프로젝트는 최대 3개입니다.")
      projectLimitView.alertMessageLabel.font = UIFont.monospacedSystemFont(ofSize: projectLimitView.alertMessageLabel.font.pointSize - 3, weight: UIFont.Weight.regular)
      projectLimitView.onlyCompleteButton()
      return projectLimitView
    case .AllowUserView:
      let allowUserView = AlertMessageView(message: "유저의 입장을 수락하시겠습니까?")
      allowUserView.completeButton.setTitle("수락하기", for: .normal)
      return allowUserView
    case .RejectUserView:
      let rejectUserView = AlertMessageView(message: "유저의 입장을 거절하시겠습니까?")
      rejectUserView.alertMessageLabel.textColor = .systemRed
      rejectUserView.completeButton.setTitleColor(.systemRed, for: .normal)
      rejectUserView.completeButton.setTitle("거절하기", for: .normal)
      return rejectUserView
    case .LogOutView:
      let logoutView = AlertMessageView(message: "로그아웃하시겠습니까?")
      return logoutView
    case .VersionUpdateRecommendView:
      let versionUpdateRecommendView = AlertMessageView(message: "앱이 새롭게 업데이트되었습니다.\n업데이트하시겠습니까?")
      versionUpdateRecommendView.completeButton.setTitle("업데이트", for: .normal)
      versionUpdateRecommendView.dismissButton.setTitle("다음에 하기", for: .normal)
      return versionUpdateRecommendView
    case .VersionUpdateRequiredView:
      let versionUpdateRequiredView = AlertMessageView(message: "앱이 새롭게 업데이트되었습니다.\n업데이트 후 이용해 주세요.")
      versionUpdateRequiredView.onlyCompleteButton()
      versionUpdateRequiredView.completeButton.setTitle("업데이트하러 가기", for: .normal)
      return versionUpdateRequiredView
    case .JumpToSettingAppView:
      let jumpToSettingAppView = AlertMessageView(message: "터미널 앱 알림 허용이 필요합니다.\niOS 알림 설정 페이지로 지금\n이동하시겠습니까?")
      return jumpToSettingAppView
    case .ReportContentView:
      let reportContentView = AlertReportContentView()
      return reportContentView
    case .ServerMaintenanceView:
      let serverMaintenanceView = AlertMessageView(message: "터미널 앱이 점검 중입니다.\n조금만 기다려주세요.\n확인 버튼을 누르면 앱이 종료됩니다.")
      serverMaintenanceView.onlyCompleteButton()
      return serverMaintenanceView
    case .LaunchDisConnectView:
      let launchDisConnectView = AlertMessageView(message: "통신이 원활하지 않습니다.\n잠시 후에 다시 시도해 주세요")
      launchDisConnectView.dismissButton.setTitle("앱 종료", for: .normal)
      launchDisConnectView.dismissButton.setTitleColor(.systemRed, for: .normal)
      launchDisConnectView.completeButton.setTitle("재시도", for: .normal)
      return launchDisConnectView
    }
  }
}


public class TerminalAlertMessage: NSObject {
  public static let sharedInstance = TerminalAlertMessage()
  public var backgroundView: UIView?
  public static var alertView: UIView?
  public static var alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
  
  public class func show(controller: UIViewController, type: AlertType) {
    TerminalAlertMessage.alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
    TerminalAlertMessage.alert.view.backgroundColor = #colorLiteral(red: 0.09019607843, green: 0.09019607843, blue: 0.1098039216, alpha: 1)
    TerminalAlertMessage.alert.view.layer.cornerRadius = 15
    
    let contentViewController = UIViewController()
    contentViewController.view = type.view
    TerminalAlertMessage.alert.setValue(contentViewController, forKey: "contentViewController")
    
    
    contentViewController.view.translatesAutoresizingMaskIntoConstraints = false
    contentViewController.view.topAnchor.constraint(equalTo: TerminalAlertMessage.alert.view.topAnchor).isActive = true
    contentViewController.view.leadingAnchor.constraint(equalTo: TerminalAlertMessage.alert.view.leadingAnchor).isActive = true
    contentViewController.view.trailingAnchor.constraint(equalTo: TerminalAlertMessage.alert.view.trailingAnchor).isActive = true
    contentViewController.view.bottomAnchor.constraint(equalTo: TerminalAlertMessage.alert.view.bottomAnchor).isActive = true
    
    TerminalAlertMessage.alert.view.translatesAutoresizingMaskIntoConstraints = false
    TerminalAlertMessage.alert.view.heightAnchor.constraint(equalToConstant: 250).isActive = true
    
    
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
  
  public class func getLeftButton() -> UIButton {
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
  
  public class func getRightButton() -> UIButton {
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
  
  public class func removeLeftButtonAction() {
    if let contentViewController = TerminalAlertMessage.alert.value(forKey: "contentViewController") {
      if let castContentViewController = contentViewController as? UIViewController {
        if let alertView = castContentViewController.view as? AlertBaseUIView {
          alertView.dismissButton.removeTarget(nil, action: nil, for: .allEvents)
        }
      }
    }
  }
  
  public class func removeRightButtonAction() {
    if let contentViewController = TerminalAlertMessage.alert.value(forKey: "contentViewController") {
      if let castContentViewController = contentViewController as? UIViewController {
        if let alertView = castContentViewController.view as? AlertBaseUIView {
          alertView.completeButton.removeTarget(nil, action: nil, for: .allEvents)
        }
      }
    }
  }
  
  @objc public class func dismiss(_ sender: UIButton? = nil) {
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
