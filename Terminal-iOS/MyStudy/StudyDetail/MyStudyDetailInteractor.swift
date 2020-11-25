//
//  MyStudyDetailInteractor.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/24.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

class MyStudyDetailInteractor: MyStudyDetailInteractorProtocol {
    var presenter: MyStudyDetailPresenterProtocol?
    var remoteDatamanager: MyStudyDetailRemoteDataManagerProtocol?
    var localDatamanager: MyStudyDetailLocalDataManagerProtocol?
}
