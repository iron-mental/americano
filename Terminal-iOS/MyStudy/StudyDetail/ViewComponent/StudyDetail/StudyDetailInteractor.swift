//
//  StudyDetailInteractor.swift
//  Terminal-iOS
//
//  Created by once on 2020/11/13.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

class StudyDetailInteractor: StudyDetailInteractorInputProtocol {
    weak var presenter: StudyDetailInteractorOutputProtocol?
    var localDatamanager: StudyDetailLocalDataManagerInputProtocol?
    var remoteDatamanager: StudyDetailRemoteDataManagerInputProtocol?
    
    func retrieveStudyDetail(studyID: String) {
        remoteDatamanager?.getStudyDetail(studyID: studyID)
    }
    
    func postStudyJoin(studyID: Int, message: String) {
        remoteDatamanager?.postStudyJoin(studyID: studyID, message: message)
    }
}

extension StudyDetailInteractor: StudyDetailRemoteDataManagerOutputProtocol {
    func onStudyDetailRetrieved(result: Bool, studyDetail: StudyDetail?, message: String?) {
        switch result {
        case true:
            guard let studyInfo = studyDetail else { return }
            presenter?.didRetrieveStudyDetail(studyInfo)
        case false:
            guard let msg = message else { return }
            presenter?.onError(message: msg)
        }
        
    }
    
    func postStudyJoinResult(result: Bool, message: String) {
        switch result {
        case true:
            presenter?.studyJoinResult(result: result, message: message)
        case false:
            presenter?.studyJoinResult(result: result, message: message)
        }
    }
}
