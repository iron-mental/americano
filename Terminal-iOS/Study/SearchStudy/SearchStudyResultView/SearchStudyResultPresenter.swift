//
//  SearchStudyResultPresenter.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/04.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation

class SearchStudyResultPresenter: SearchStudyResultPresenterProtocol {
    weak var view: SearchStudyResultViewProtocol?
    var interactor: SearchStudyResultInteractorInputProtocol?
    var wireFrame: SearchStudyResultWireFrameProtocol?
    
    func returnDidTap(keyWord: String) {
        view?.showLoading()
        interactor?.getSearchStudyList(keyWord: keyWord)
    }
    
    func didTapCell(keyValue: Int, state: Bool, studyTitle: String) {
        view?.showLoading()
        wireFrame?.presentStudyDetailScreen(from: view!, keyValue: keyValue, state: state, studyTitle: studyTitle)
    }
    
    func scrollToBottom() {
        interactor?.getPagingStudyList()
    }
    
}

extension SearchStudyResultPresenter: SearchStudyResultInteractorOutputProtocol {
    func showSearchStudyListResult(result: [Study]) {
        view?.showSearchStudyListResult(result: result) {
            self.view?.hideLoading()
        }
    }
    
    func showPagingStudyListResult(result: [Study]) {
        view?.showPagingStudyListResult(result: result)
    }
    
    func showError(message: String) {
        view?.hideLoading()
        view?.showError(message: message)
    }
    func sessionTaskError(message: String) {
        view?.hideLoading()
        view?.showError(message: message)
    }
}
