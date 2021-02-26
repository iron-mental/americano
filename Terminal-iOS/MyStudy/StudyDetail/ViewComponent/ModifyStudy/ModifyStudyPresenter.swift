//
//  ModifyStudyPresenter.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/19.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

class ModifyStudyPresenter: ModifyStudyPresenterProtocol {
    weak var view: ModifyStudyViewProtocol?
    var interactor: ModifyStudyInteractorInputProtocol?
    var wireFrame: ModifyStudyWireFrameProtocol?
    
    func clickLocationView(currentView: UIViewController) {
        wireFrame?.goToSelectLocation(view: currentView)
    }
    
    func completButtonDidTap(studyID: Int, study: StudyDetailPost) {
        view?.showLoading()
        interactor?.putStudyInfo(studyID: studyID, study: study)
    }
}

extension ModifyStudyPresenter: ModifyStudyInteractorOutputProtocol {
    func putStudyInfoResult(result: Bool, message: String) {
        view?.hideLoading()
        switch result {
        case true:
            self.view?.showResult(message: message)
        case false:
            self.view?.showError(message: message)
        }
    }
}
