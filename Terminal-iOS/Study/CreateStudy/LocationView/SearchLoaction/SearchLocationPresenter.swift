//
//  SearchLocationPresenter.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/10/29.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class SearchLocationPresenter: SearchLocationPresenterProtocol {
    weak var view: SearchLocationViewProtocol?
    var interactor: SearchLocationInteractorProtocol?
    var wireFrame: SearchLocationWireFrameProtocol?
    
    func didSelectedItem(item: StudyDetailLocationPost, view: UIViewController, parentView: UIViewController) {
        wireFrame?.goToSelectLocationView(item: item, view: view, parentView: parentView)
    }
    
    func didClickedSearchButton(text: String) {
        view?.showLoading()
        interactor?.searchKeyWord(text: text)
    }
    
    func searchResult(list: [StudyDetailLocationPost]) {
        view?.hideLoading()
        view?.showSearchResult(list: list)
    }
    func sessionTaskError(message: String) {
        view?.hideLoading()
        view?.showError(message: message)
    }
}
