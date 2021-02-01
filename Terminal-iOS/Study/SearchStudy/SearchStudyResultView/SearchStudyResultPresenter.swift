//
//  SearchStudyResultPresenter.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/04.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation

class SearchStudyResultPresenter: SearchStudyResultPresenterProtocol {
    var view: SearchStudyResultViewProtocol?
    var interactor: SearchStudyResultInteractorInputProtocol?
    var wireFrame: SearchStudyResultWireFrameProtocol?
    
    func returnDidTap(keyWord: String) {
        view?.showLoading()
        interactor?.getSearchStudyList(keyWord: keyWord)
    }
    
    func didTapCell(keyValue: Int, state: Bool) {
        wireFrame?.presentStudyDetailScreen(from: view!, keyValue: keyValue, state: state)
    }
    
    func scrollToBottom() {
        interactor?.getPagingStudyList()
    }
    
}

extension SearchStudyResultPresenter: SearchStudyResultInteractorOutputProtocol {
    func showSearchStudyListResult(result: [Study]) {
        view?.hideLoading()
        view?.showSearchStudyListResult(result: result)
    }
    
    func showPagingStudyListResult(result: [Study]) {
        view?.showSearchStudyListResult(result: result)
    }
}
