//
//  ProfileModifyInteractor.swift
//  Terminal-iOS
//
//  Created by once on 2020/11/30.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

class ProfileModifyInteractor: ProfileModifyInteractorInputProtocol {
   
    
    var presenter: ProfileModifyInteractorOutputProtocol?
    var remoteDataManager: ProfileModifyRemoteDataManagerInputProtocol?
    
    func completeModify(userInfo: UserInfoPut, project: [Project]) {
        remoteDataManager?.validProfileModify(userInfo: userInfo)
        
        
    }
}

extension ProfileModifyInteractor: ProfileModifyRemoteDataManagerOutputProtocol {
    
}
