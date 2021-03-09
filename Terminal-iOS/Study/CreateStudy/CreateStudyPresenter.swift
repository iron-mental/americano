//
//  CreateStudyPresenter.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/15.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

final class CreateStudyPresenter: CreateStudyPresenterProtocol {
    weak var view: CreateStudyViewProtocol?
    var interactor: CreateStudyInteractorInputProtocol?
    var wireFrame: CreateStudyWireFrameProtocol?
    
    func viewDidLoad() {
        view?.setView()
    }
    
    func clickLocationView() {
        wireFrame?.goToSelectLocation(from: view!)
    }
    
    func clickCompleteButton(study: StudyDetailPost, studyID: Int?) {
        view?.showLoading()
        interactor?.studyCreateComplete(study: study, studyID: studyID ?? nil)
    }
}

extension CreateStudyPresenter: CreateStudyInteractorOutputProtocol {
    func studyInfoInvalid(label: String?, message: String) {
        view?.hideLoading()
        guard let label = label else {
            view?.studyInfoInvalid(label: nil, message: message)
            return
        }
        view?.studyInfoInvalid(label: label, message: message)
    }
    
    func studyInfoValid(studyID: Int, message: String) {
        view?.hideLoading()
        view?.studyInfoValid(studyID: studyID, message: message)
    }
    
    func sessionTaskError(message: String) {
        view?.hideLoading()
        view?.showError(message: message)
    }
}
