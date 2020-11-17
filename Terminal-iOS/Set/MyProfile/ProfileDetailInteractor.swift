//
//  ProfileModifyInteractor.swift
//  Terminal-iOS
//
//  Created by once on 2020/10/08.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

class ProfileDetailInteractor: ProfileDetailInteractorInputProtocol {
    var presenter: ProfileDetailInteractorOutputProtocol?
    var localDataManager: ProfileDetailLocalDataManagerInputProtocol?
    var remoteDataManager: ProfileDetailRemoteDataManagerInputProtocol?
    
    
}

extension ProfileDetailInteractor: ProfileDetailRemoteDataManagerOutputProtocol {
    
}
