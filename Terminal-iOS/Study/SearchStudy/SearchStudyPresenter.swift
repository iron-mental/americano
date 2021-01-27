//
//  SearchStudyPresenter.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/12/30.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

class SearchStudyPresenter: SearchStudyPresenterProtocol {
    var view: SearchStudyViewProtocol?
    var interactor: SearchStudyInteractorProtocol?
    var wireFrame: SearchStudyWireFrameProtocol?
    
    func didSearchButtonClicked(keyword: String) {
        wireFrame?.goToSearchStudyRestult(from: view!, keyword: keyword)
    }
}
