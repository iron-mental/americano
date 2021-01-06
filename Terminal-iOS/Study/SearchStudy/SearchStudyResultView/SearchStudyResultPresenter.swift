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
    var interactor: SearchStudyResultInteractorProtocol?
    var wireFrame: SearchStudyResultWireFrameProtocol?
    
    func returnDidTap(keyWord: String) {
        view?.showLoading()
        interactor?.getSearchStudyResult(keyWord: keyWord)
    }
    
    func showSearchStudyResult(result: [Study]) {
        view?.hideLoading()
        view?.showSearchStudyResult(result: result)
    }
    
    func didTapCell(keyValue: Int, state: Bool) {
//        if state {
//            wireFrame?.presentMyStudyDetail(from: view!, keyValue: keyValue)
//        } else {
            wireFrame?.presentStudyDetailScreen(from: view!, keyValue: keyValue, state: state)
//        }
    }
}
