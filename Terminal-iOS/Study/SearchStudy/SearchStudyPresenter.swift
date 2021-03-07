//
//  SearchStudyPresenter.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/12/30.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

class SearchStudyPresenter: SearchStudyPresenterProtocol {
    weak var view: SearchStudyViewProtocol?
    var interactor: SearchStudyInteractorInputProtocol?
    var wireFrame: SearchStudyWireFrameProtocol?
    
    func didSearchButtonClicked(keyword: String) {
        wireFrame?.goToSearchStudyRestult(from: view!, keyword: keyword)
    }
    
    func viewDidLoad() {
        view?.showLoading()
        interactor?.getHotKeyword()
    }
}

extension SearchStudyPresenter: SearchStudyInteractorOutputProtocol {
    func getHotKeywordSuccess(keyword: [HotKeyword]) {
        view?.showHotkeyword(keyword: keyword)
    }
    
    func getHotKeywordFailure(message: String) {
        view?.showError(message: message)
    }
    
    func sessionTaskError(message: String) {
        view?.hideLoading()
        view?.showError(message: message)
    }
}
