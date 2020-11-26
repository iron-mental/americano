//
//  StudyListPresenter.swift
//  Terminal-iOS
//
//  Created by once on 2020/09/14.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class StudyListPresenter: StudyListPresenterProtocol {
    func showStudyDetail(keyValue: Int) {
        wireFrame?.presentStudyDetailScreen(from: view!, keyValue: keyValue)
    }
    
    var view: StudyListViewProtocol?
    var interactor: StudyListInteractorInputProtocol?
    var wireFrame: StudyListWireFrameProtocol?
    
    func studyList(category: String) {
        interactor?.retrieveStudyList(category: category)
    }
    
    func pagingStudyList() {
        interactor?.pagingRetrieveStudyList()
    }
    
    func pagingLengthStudyList() {
        interactor?.pagingRetrieveLengthStudyList()
    }
}

extension StudyListPresenter: StudyListInteractorOutputProtocol {
    func didRetrieveStudies(studies: [Study]) {
        view?.showStudyList(with: studies)
    }
    
    func didRetrieveLengthStudies(studies: [Study]) {
        view?.saveLengthStudyList(with: studies)
    }
      
    func onError() {
        
    }
}
