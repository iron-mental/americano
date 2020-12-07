//
//  SetInteractor.swift
//  Terminal-iOS
//
//  Created by once on 2020/10/07.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

class SetInteractor: SetInteractortInputProtocol {
    var presenter: SetInteractorOutputProtocol?
    var localDatamanager: SetLocalDataManagerInputProtocol?
    var remoteDatamanager: SetRemoteDataManagerInputProtocol?
    
    func getUserInfo() {
        remoteDatamanager?.getUserInfo(id: 44)
    }
}

extension SetInteractor: SetRemoteDataManagerOutputProtocol {
    
}
