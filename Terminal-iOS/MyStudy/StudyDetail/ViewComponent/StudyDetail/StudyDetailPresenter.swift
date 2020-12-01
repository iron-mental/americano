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
    
    func showStudyListDetail(keyValue: String) {
        interactor?.retrieveStudyDetail(keyValue: keyValue)
    }
    
    func goToStudyDetail(studyDetail: StudyDetail) {
        
    }
    
    func didClickedCreateButton() {
        
    }
    func joinButtonDidTap(studyID: Int, message: String) {
        interactor?.postStudyJoin(studyID: studyID, message: message)
    }
    
}

extension StudyDetailPresenter: StudyDetailInteractorOutputProtocol {
    func didRetrieveStudyDetail(_ studyDetail: StudyDetail) {
        view?.showStudyDetail(with: studyDetail)
    }
    
    func onError() {
        
    }
    func studyJoinResult(result: Bool, message: String) {
        view?.studyJoinResult(message: message)
    }
}
