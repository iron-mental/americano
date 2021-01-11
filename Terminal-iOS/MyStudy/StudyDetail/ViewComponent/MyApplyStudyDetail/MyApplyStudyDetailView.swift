//
//  MyApplyStudyDetailView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/11.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

class MyApplyStudyDetailView: UIViewController {
    var presenter: MyApplyStudyDetailPresenterInputProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
}

extension MyApplyStudyDetailView: MyApplyStudyDetailViewProtocol {
    
}
