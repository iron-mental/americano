//
//  StudyDetailPresenter.swift
//  Terminal-iOS
//
//  Created by once on 2020/11/13.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

final class StudyDetailPresenter: StudyDetailPresenterProtocol {
    weak var view: StudyDetailViewProtocol?
    var interactor: StudyDetailInteractorInputProtocol?
    var wireFrame: StudyDetailWireFrameProtocol?
    
    func viewDidLoad() {
        
    }
    
    func showStudyListDetail(studyID: String) {
        view?.showLoading()
        interactor?.retrieveStudyDetail(studyID: studyID)
    }
    
    func goToStudyDetail(studyDetail: StudyDetail) {
        
    }
    
    func didClickedCreateButton() {
        
    }
    func joinButtonDidTap(studyID: Int, message: String) {
        view?.showLoading()
        interactor?.postStudyJoin(studyID: studyID, message: message)
    }
    
    func modifyStudyMessageButtonDidTap(studyID: Int) {
        wireFrame?.goToApplyStudyDetail(from: view!, studyID: studyID)
    }
    
    func memberDidTap(userID: Int) {
        wireFrame?.goToParticipantProfile(from: view!, userID: userID)
    }
}

extension StudyDetailPresenter: StudyDetailInteractorOutputProtocol {
    func didRetrieveStudyDetail(_ studyDetail: StudyDetail) {
        if view?.parentView == nil {
            view?.hideLoading()
        }
        view?.showStudyDetail(with: studyDetail)
    }
    
    func onError(message: String) {
        
        view?.showError(message: message)
    }
    
    func studyJoinResult(result: Bool, message: String) {
        switch result {
        case true:
            view?.hideLoading()
            view?.studyJoinResult(message: message)
        case false:
            view?.hideLoading()
            view?.showError(message: message)
        }
    }

}
