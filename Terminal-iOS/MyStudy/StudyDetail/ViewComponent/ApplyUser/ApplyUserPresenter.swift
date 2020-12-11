//
//  ApplyUserPresenter.swift
//  Terminal-iOS
//
//  Created by once on 2020/12/11.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

class ApplyUserPresenter: ApplyUserPresenterProtocol {
    var view: ApplyUserViewProtocol?
    var interactor: ApplyUserInteractorInputProtocol?
    var wireFrame: ApplyUserWireFrameProtocol?
    
    func viewDidLoad(studyID: Int) {
        interactor?.getApplyList(studyID: studyID)
    }
    
    func showUserInfoDetail(userID: Int, state: Bool) {
        wireFrame?.presentUserInfoDetailScreen(from: view!)
    }
}


extension ApplyUserPresenter: ApplyUserInteractorOutputProtocol {
    func didRetrieveUser(userList: [ApplyUser]?) {
        view?.showUserList(userList: userList)
    }
    
    func onError() {
        
    }
    
}
