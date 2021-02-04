//
//  ApplyUserPresenter.swift
//  Terminal-iOS
//
//  Created by once on 2020/12/11.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

class ApplyUserPresenter: ApplyUserPresenterProtocol {
    weak var view: ApplyUserViewProtocol?
    var interactor: ApplyUserInteractorInputProtocol?
    var wireFrame: ApplyUserWireFrameProtocol?
    
    func viewDidLoad(studyID: Int) {
        LoadingRainbowCat.show()
        interactor?.getApplyList(studyID: studyID)
    }
    
    func showUserInfoDetail(userInfo: ApplyUser, studyID: Int) {
        wireFrame?.presentUserInfoDetailScreen(from: view!, userInfo: userInfo, studyID: studyID)
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
