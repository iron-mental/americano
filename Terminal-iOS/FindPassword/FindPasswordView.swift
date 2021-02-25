//
//  FindPasswordView.swift
//  Terminal-iOS
//
//  Created by once on 2021/02/26.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

final class FindPasswordView: UIViewController {
    var presenter: FindPasswordPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension FindPasswordView: FindPasswordViewProtocol {
        
}
