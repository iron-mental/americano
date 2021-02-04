//
//  MyApplyStudyInfoInteractor.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/29.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation

class MyApplyStudyInfoInteractor: MyApplyStudyInfoInteractorInputProtocol {
    weak var presenter: MyApplyStudyInfoInteractorOutputProtocol?
    var remoteDataManager: MyApplyStudyInfoRemoteDataManagerInputProtocol?
    var applyID: Int?
    var studyID: Int?
    
    func deleteApply() {
        if let applyIdentifier = applyID, let studyIdentifier = studyID {
            remoteDataManager?.deleteApply(studyID: studyIdentifier, applyID: applyIdentifier)
        }
    }
}

extension MyApplyStudyInfoInteractor: MyApplyStudyInfoRemoteDataManagerOutputProtocol {
    func retriveDeleteApplyResult(result: Bool, message: String) {
        switch result {
        case true:
            presenter?.retriveDeleteApplyResult(result: result, message: message)
        case false:
            presenter?.retriveDeleteApplyResult(result: result, message: message)
        }
    }
}
