//
//  ApplyUserDetailPresenter.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/15.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation

class ApplyUserDetailPresenter: ApplyUserDetailPresenterInputProtocol {
    var view: ApplyUserDetailViewProtocol?
    var interactor: ApplyUserDetailInteractorInputProtocol?
    var wireFrame: ApplyUserDetailWireFrameProtocol?
    
    func viewDidLoad(userID: Int) {
//        <#code#>
    }

}

extension ApplyUserDetailPresenter: ApplyUserDetailInteractorOutputProtocol {
    func retriveUserInfo(result: Bool, userInfo: UserInfo) {
//        <#code#>
    }
    
    func retriveProjectList(result: Bool, projectList: [Project]) {
//        <#code#>
    }
}
