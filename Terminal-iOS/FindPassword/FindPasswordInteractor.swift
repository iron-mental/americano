//
//  FindPasswordInteractor.swift
//  Terminal-iOS
//
//  Created by once on 2021/02/26.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation

final class FindPasswordInteractor: FindPasswordInteractorInputProtocol {
    var presenter: FindPasswordInteractorOutputProtocol?
    var remoteDataManager: FindPasswordRemoteDataManagerInputProtocol?
    
}

extension FindPasswordInteractor: FindPasswordRemoteDataManagerOutputProtocol {
    
}
