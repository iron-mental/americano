//
//  SetViewInteractor.swift
//  Terminal-iOS
//
//  Created by once on 2020/09/30.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class SetViewInteractor: SetViewInteractortInputProtocol {
    
    var presenter: SetViewInteractorOutputProtocol?
    
    var localDatamanager: SetViewLocalDataManagerInputProtocol?
    
    var remoteDatamanager: SetViewRemoteDataManagerInputProtocol?
}

extension SetViewInteractor: SetViewRemoteDataManagerOutputProtocol {
    
}
