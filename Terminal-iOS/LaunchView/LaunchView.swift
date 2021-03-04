//
//  LaunchView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/02/23.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

class LaunchView: UIViewController {
    var presenter: LaunchPresenterProtocol?
    let appearance = UINavigationBarAppearance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        presenter?.viewDidLoad()
    }
    
    func attribute() {
        appearance.do {
            $0.configureWithTransparentBackground()
        }
        navigationController?.do {
            $0.navigationBar.standardAppearance = appearance
        }
        view.do {
            $0.backgroundColor = .appColor(.terminalBackground)
        }
    }
    
    // MARK: @objc
    @objc func updateButtonDidtap() {
        presenter?.jumpToAppStore()
    }
    
    @objc func updateLaterButtonDidTap() {
        presenter?.getRefreshTokenValid()
    }
    
    @objc func terminatedButtonDidTap() {
        exit(0)
    }
}

extension LaunchView: LaunchViewProtocol {
    func showVersionUpdateAlert(alertType: AlertType) {
        TerminalAlertMessage.show(controller: self, type: alertType)
        TerminalAlertMessage.removeLeftButtonAction()
        TerminalAlertMessage.removeRightButtonAction()
        TerminalAlertMessage.getRightButton().addTarget(self, action: #selector(updateButtonDidtap), for: .touchUpInside)
        TerminalAlertMessage.getLeftButton().addTarget(self, action: #selector(updateLaterButtonDidTap), for: .touchUpInside)
    }
    
    func showError(message: String) {
        //좀더 생각을 해보는 걸로 
    }
    
    func showMainTenanceAlert() {
        TerminalAlertMessage.show(controller: self, type: .ServerMaintenanceView)
        TerminalAlertMessage.removeRightButtonAction()
        TerminalAlertMessage.getRightButton().addTarget(self, action: #selector(terminatedButtonDidTap), for: .touchUpInside)
    }
}
