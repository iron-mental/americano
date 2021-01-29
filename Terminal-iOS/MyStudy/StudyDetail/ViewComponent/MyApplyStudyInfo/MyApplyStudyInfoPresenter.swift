//
//  MyApplyStudyInfoPresenter.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/29.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

class MyApplyStudyInfoPresenter: MyApplyStudyInfoPresenterInputProtocol {
    var view: MyApplyStudyInfoViewProtocol?
    var wireFrame: MyApplyStudyInfoWireFrameProtocol?
    
    func modifyButtonDidTap(studyID: Int) {
        if let parentView = view as? UIViewController {
            wireFrame?.goToMyApplyStudyModify(from: parentView, studyID: studyID)
        }
    }
}
