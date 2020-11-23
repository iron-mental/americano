//
//  ProfileModifyPresenter.swift
//  Terminal-iOS
//
//  Created by once on 2020/10/08.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

class ProfileDetailPresenter: ProfileDetailPresenterProtocol {
    var view: ProfileDetailViewProtocol?
    
    var interactor: ProfileDetailInteractorInputProtocol?
    
    var wireFrame: ProfileDetailWireFrameProtocol?
    
    
}

extension ProfileDetailPresenter: ProfileDetailInteractorOutputProtocol {
    
}
