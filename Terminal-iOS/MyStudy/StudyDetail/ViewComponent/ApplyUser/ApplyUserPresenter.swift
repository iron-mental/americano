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
        LoadingRainbowCat.show()
        interactor?.getApplyList(studyID: studyID)
    }
    
    func showUserInfoDetail(userID: Int, state: Bool) {
        wireFrame?.presentUserInfoDetailScreen(from: view!, userID: userID)
    }
}


extension ApplyUserPresenter: ApplyUserInteractorOutputProtocol {
    func didRetrieveUser(userList: [ApplyUser]?) {
        LoadingRainbowCat.hide {
            self.view?.showUserList(userList: userList)
        }
    }
    
    func onError() {
        LoadingRainbowCat.hide {
            print("ApplyUserPresenter 에서 생긴 오류")
        }
    }
}
