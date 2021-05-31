//
//  LaunchView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/02/23.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit
import TerminalAlert

final class LaunchView: UIViewController {
    var presenter: LaunchPresenterProtocol?
    let appearance = UINavigationBarAppearance()
    var splashImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
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
        splashImageView.do {
            $0.image = #imageLiteral(resourceName: "smallertmn")
            $0.contentMode = .scaleAspectFit
        }
    }
    
    func layout() {
        [ splashImageView ].forEach { self.view.addSubview($0) }
        
        splashImageView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.bottomAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -50).isActive = true
            $0.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 100).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 100).isActive = true
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
    
    @objc func retry() {
        TerminalAlertMessage.dismiss()
        viewDidLoad()
    }
}

extension LaunchView: LaunchViewProtocol {
    func showVersionUpdateAlert(alertType: AlertType) {
        TerminalAlertMessage.show(controller: self, type: alertType)
        TerminalAlertMessage.removeLeftButtonAction()
        TerminalAlertMessage.removeRightButtonAction()
        TerminalAlertMessage.getRightButton().addTarget(self,
                                                        action: #selector(updateButtonDidtap),
                                                        for: .touchUpInside)
        TerminalAlertMessage.getLeftButton().addTarget(self,
                                                       action: #selector(updateLaterButtonDidTap),
                                                       for: .touchUpInside)
    }
    
    func showError(message: String) {
        TerminalAlertMessage.show(controller: self, type: .LaunchDisConnectView)
        TerminalAlertMessage.removeLeftButtonAction()
        TerminalAlertMessage.removeRightButtonAction()
        TerminalAlertMessage.getLeftButton().addTarget(self,
                                                       action: #selector(terminatedButtonDidTap),
                                                       for: .touchUpInside)
        TerminalAlertMessage.getRightButton().addTarget(self,
                                                        action: #selector(retry),
                                                        for: .touchUpInside)
    }
    
    func showMainTenanceAlert() {
        TerminalAlertMessage.show(controller: self, type: .ServerMaintenanceView)
        TerminalAlertMessage.removeRightButtonAction()
        TerminalAlertMessage.getRightButton().addTarget(self,
                                                        action: #selector(terminatedButtonDidTap),
                                                        for: .touchUpInside)
    }
}
