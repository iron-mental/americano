//
//  MyApplyListPresenter.swift
//  Terminal-iOS
//
//  Created by once on 2020/12/11.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation
 
class MyApplyListPresenter: MyApplyListPresenterProtocol {
    var view: MyApplyListViewProtocol?
    var interactor: MyApplyListInteractorInputProtocol?
    var wireFrame: MyApplyListWireFrameProtocol?
    
    func viewDidLoad() {
        interactor?.getApplyList()
    }
    
    func showStudyDetail(keyValue: Int, state: Bool) {
        
    }
}

extension MyApplyListPresenter: MyApplyListInteractorOutputProtocol {
    func didRetrieveStudies(studies: [Study]) {
        
    }
    
    func onError() {
        
    }
    
}
