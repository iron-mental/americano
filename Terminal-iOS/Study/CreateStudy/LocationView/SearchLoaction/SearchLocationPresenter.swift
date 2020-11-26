//
//  SearchLocationPresenter.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/10/29.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class SearchLocationPresenter: SearchLocationPresenterProtocol {
   
    
    var view: SearchLocationViewProtocol?
    var interactor: SearchLocationInteractorProtocol?
    var wireFrame: SearchLocationWireFrameProtocol?
    
    func didSelectedItem(item: StudyDetailLocationPost, view: UIViewController) {
        wireFrame?.goToSelectLocationView(item: item, view: view)
    }
    
    func didClickedSearchButton(text: String) {
        interactor?.searchKeyWord(text: text)
    }
    
    func searchResult(list: [StudyDetailLocationPost]) {
        view?.showSearchResult(list: list)
    }
    
}
