//
//  CreateStudyPresenter.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/15.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class CreateStudyPresenter: CreateStudyPresenterProtocol {
    var view: CreateStudyViewProtocol?
    var interactor: CreateStudyInteractorInputProtocol?
    var wireFrame: CreateStudyWireFrameProtocol?
    
    func viewDidLoad() {
        view?.setView()
    }
    func clickLocationView(currentView: UIViewController) {
        wireFrame?.goToSelectLocation(view: currentView)
    }
    
    func clickCompleteButton(study: StudyDetailPost, studyID: Int?) {
        view?.showLoading()
        interactor?.studyCreateComplete(study: study, studyID: studyID ?? nil)
    }
    
    
}

extension CreateStudyPresenter: CreateStudyInteractorOutputProtocol {
    func studyInfoInvalid(message: String) {
        view?.hideLoading()
        view?.studyInfoInvalid(message: message)
    }
    
    func studyInfoValid(studyID: Int) {
        view?.hideLoading()
        view?.studyInfoValid(studyID: studyID, message: "스터디 생성이 완료되었습니다.")
    }
}
