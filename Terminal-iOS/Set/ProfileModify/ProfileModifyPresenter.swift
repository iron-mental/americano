//
//  ProfileModifyPresenter.swift
//  Terminal-iOS
//
//  Created by once on 2020/11/30.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

class ProfileModifyPresenter: ProfileModifyPresenterProtocol {
    var view: ProfileModifyViewProtocol?
    var interactor: ProfileModifyInteractorInputProtocol?
    var wireFrame: ProfileModifyWireFrameProtocol?

    func completeModifyButton(userInfo: UserInfoPut) {
        interactor?.completeModify(userInfo: userInfo)
    }
}

extension ProfileModifyPresenter: ProfileModifyInteractorOutputProtocol {
    
}
