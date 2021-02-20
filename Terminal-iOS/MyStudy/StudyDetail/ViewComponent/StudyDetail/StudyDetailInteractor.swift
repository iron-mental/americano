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
    func onStudyDetailRetrieved(result: BaseResponse<StudyDetailInfo>) {
        switch result.result {
        case true:
            guard let studyInfo = result.data?.studyInfo else { return }
            presenter?.didRetrieveStudyDetail(studyInfo)
        case false:
            guard let msg = result.message else { return }
            presenter?.onError(message: msg)
        }
        
    }
    
    func postStudyJoinResult(result: BaseResponse<String>) {
        guard let message = result.message else { return }
        presenter?.studyJoinResult(result: result.result, message: message)
    }
    
    func alertGotConfirmed() {
        presenter?.alertGotConfirmed()
    }
}
