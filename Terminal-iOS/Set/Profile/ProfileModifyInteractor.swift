//
//  ProfileModifyInteractor.swift
//  Terminal-iOS
//
//  Created by once on 2020/11/30.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class ProfileModifyInteractor: ProfileModifyInteractorInputProtocol {
    var presenter: ProfileModifyInteractorOutputProtocol?
    var remoteDataManager: ProfileModifyRemoteDataManagerInputProtocol?
    
    func viewDidLoad() {
        remoteDataManager?.authCheck {}
    }
    
    func completeModify(profile: Profile) {
//        remoteDataManager?.validProfileModify(userInfo: userInfo)
        print("profile:", profile)
    }
}

extension ProfileModifyInteractor: ProfileModifyRemoteDataManagerOutputProtocol {
    
}
