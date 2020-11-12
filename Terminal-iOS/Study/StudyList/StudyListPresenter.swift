//
//  StudyListPresenter.swift
//  Terminal-iOS
//
//  Created by once on 2020/09/14.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class StudyListPresenter: StudyListPresenterProtocol {
    var view: StudyListViewProtocol?
    var interactor: StudyListInteractorInputProtocol?
    var wireFrame: StudyListWireFrameProtocol?
    
    func studyList(category: String, sort: String) {
        interactor?.retrieveStudyList(category: category, sort: sort)
    }
    
    func pagingStudyList(keyValue: [Int]) {
        interactor?.pagingRetrieveStudyList(keyValue: keyValue)
    }
}

extension StudyListPresenter: StudyListInteractorOutputProtocol {
    func didRetrieveStudies(_ studies: [Study]) {
        view?.showStudyList(with: studies)
    }
    
    func onError() {
        
    }
}
