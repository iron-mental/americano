//
//  MyApplyStudyDetailView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/29.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

class MyApplyStudyInfoView: UIViewController {
    var applyStudy: ApplyStudy?
    
    let mainImageView = UIImageView()
    let studyTitleLabel = PaddingLabel()
    let applyMessageLabel = PaddingLabel()
    
    func attribute() {
        mainImageView.do {
            guard let image = applyStudy?.image else { return }
            $0.kf.setImage(with: URL(string: image), options: [.requestModifier(RequestToken.token())])
        }
        studyTitleLabel.do {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        
    }
    
}

extension MyApplyStudyInfoView: MyApplyStudyInfoViewProtocol {
    
}
