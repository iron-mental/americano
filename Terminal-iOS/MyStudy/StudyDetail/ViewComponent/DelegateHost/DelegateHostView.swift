//
//  DelegateHostView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/21.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

class DelegateHostView: UIViewController {
    var presenter: DelegateHostPresenterProtocol?
    var userList: [Participate]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension DelegateHostView: DelegateHostViewProtocol {
    func showDelegateHostResult(message: String) {
        <#code#>
    }
    
    func showError() {
        <#code#>
    }
}
