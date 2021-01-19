//
//  ModifyStudyInteractor.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/19.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation

class ModifyStudyInteractor: ModifyStudyInteractorInputProtocol {
    var presenter: ModifyStudyInteractorOutputProtocol?
    var remoteDataManager: ModifyStudyRemoteDataManagerInputProtocol?
    var currentStudy: StudyDetail?
    
    func putStudyInfo(studyID: Int, study: StudyDetailPost) {
        remoteDataManager?.putStudyInfo(studyID: studyID, study: study)
    }
    
}

extension ModifyStudyInteractor: ModifyStudyRemoteDataManagerOutputProtocol {
    func putStudyInfoResult(result: Bool, message: String) {
        switch result {
        case true:
            presenter?.putStudyInfoResult(result: result, message: message)
            break
        case false:
            presenter?.putStudyInfoResult(result: result, message: message)
            break
        }
    }
}
