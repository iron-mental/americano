//
//  MyApplyStudyInfoPresenter.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/29.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

class MyApplyStudyInfoPresenter: MyApplyStudyInfoPresenterProtocol {
    var view: MyApplyStudyInfoViewProtocol?
    var wireFrame: MyApplyStudyInfoWireFrameProtocol?
    var interactor: MyApplyStudyInfoInteractorInputProtocol?
    
    func modifyButtonDidTap(studyID: Int) {
        if let parentView = view as? UIViewController {
            wireFrame?.goToMyApplyStudyModify(from: parentView, studyID: studyID)
        }
    }
    
    func deleteButtonDidTap() {
        interactor?.deleteApply()
    }
}

extension MyApplyStudyInfoPresenter: MyApplyStudyInfoInteractorOutputProtocol {
    func retriveDeleteApplyResult(result: Bool, message: String) {
        switch result {
        case true:
            view?.showDeleteApply(message: message)
        case false:
            view?.showError(message: message)
        }
    }
}
