//
//  StudyDetailPresenter.swift
//  Terminal-iOS
//
//  Created by once on 2020/11/13.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

class StudyDetailPresenter: StudyDetailPresenterProtocol {
    var view: StudyDetailViewProtocol?
    var interactor: StudyDetailInteractorInputProtocol?
    var wireFrame: StudyDetailWireFrameProtocol?

    func viewDidLoad() {
        
    }
    
    func showStudyListDetail(studyID: String) {
        interactor?.retrieveStudyDetail(studyID: studyID)
    }
    
    func goToStudyDetail(studyDetail: StudyDetail) {
        
    }
    
    func didClickedCreateButton() {
        
    }
    func joinButtonDidTap(studyID: Int, message: String) {
        interactor?.postStudyJoin(studyID: studyID, message: message)
    }
    func modifyStudyMessageButtonDidTap(studyID: Int) {
        wireFrame?.goToApplyStudyDetail(from: view!, studyID: studyID)
    }
}

extension StudyDetailPresenter: StudyDetailInteractorOutputProtocol {
    func didRetrieveStudyDetail(_ studyDetail: StudyDetail) {
        view?.showStudyDetail(with: studyDetail)
    }
    
    func onError() {
        
    }
    func studyJoinResult(result: Bool, message: String) {
        switch result {
        case true:
            view?.studyJoinResult(message: message)
        case false:
            view?.showError(message: message)
        }
    }
}
