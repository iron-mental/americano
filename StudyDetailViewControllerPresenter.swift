//
//  StudyDetailViewControllerPresenter.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/17.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

class StudyDetailViewControllerPresenter: StudyDetailViewControllerPresenterProtocol {
    
    var view: StudyDetailViewControllerViewProtocol?
    
    var interactor: StudyDetailViewControllerInteractorProtocol?
    
    var wireFrame: StudyDetailViewControllerWireFrameProtocol?
    
    func viewDidLoad(study: MyStudy) {
        interactor?.getStudyDetailInfo(study: study)
    }
    
    func studyDetailInfoResult(result: Bool, studyInfo: StudyDetail) {
        switch result {
        case true:
            view?.showStudyDetailResult(studyInfo: studyInfo)
            break
        case false:
            break
        }
    }
}
