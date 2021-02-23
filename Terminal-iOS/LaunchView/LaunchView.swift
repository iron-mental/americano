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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
}

extension LaunchView: LaunchViewProtocol {
    func showVersionUpdateAlert(alertType: AlertType) {
        TerminalAlertMessage.show(controller: self, type: alertType)
    }
    
    func showError(message: String) {
        //좀더 생각을 해보는 걸로 
    }
}
