//
//  StudyListPresenter.swift
//  Terminal-iOS
//
//  Created by once on 2020/09/14.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class StudyListPresenter: StudyListPresenterProtocol {
    weak var view: StudyListViewProtocol?
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
    func showStudyDetail(keyValue: Int, state: Bool, studyTitle: String) {
        view?.showLoading()
        wireFrame?.presentStudyDetailScreen(from: view!, keyValue: keyValue, state: state, studyTitle: studyTitle)
    }
}

extension StudyListPresenter: StudyListInteractorOutputProtocol { 
    func didRetrieveLatestStudies(studies: [Study]) {
        view?.hideLoading()
        view?.showStudyList(with: studies)
    }
    
    func didRetrieveLengthStudies(studies: [Study]) {
        view?.hideLoading()
        view?.saveLengthStudyList(with: studies)
    }
    
    func sessionTaskError(message: String) {
        view?.hideLoading()
        view?.showError(message: message)
    }
}
