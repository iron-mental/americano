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
    
    func showStudyListDetail() {
        
    }
    
    func goToStudyDetail(studyDetail: StudyDetail) {
        
    }
    
    func didClickedCreateButton() {
        
    }
}

extension StudyDetailPresenter: StudyDetailInteractorOutputProtocol {
    func didRetrieveStudyDetail(_ studyDetail: StudyDetail) {
        
    }
    
    func onError() {
        
    }
}
