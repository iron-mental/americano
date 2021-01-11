//
//  MyApplyStudyDetailInteractor.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/11.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation

class MyApplyStudyDetailInteractor: MyApplyStudyDetailInteractorInputProtocol {
    var presenter: MyApplyStudyDetailInteractorOutputProtocol?
    var remoteDataManager: MyApplyStudyDetailRemoteDataManagerInputProtocol?
}

extension MyApplyStudyDetailInteractor: MyApplyStudyDetailRemoteDataManagerOutputProtocol {
    
}
