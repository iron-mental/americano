//
//  StudyDetailInteractor.swift
//  Terminal-iOS
//
//  Created by once on 2020/11/13.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

class StudyDetailInteractor: StudyDetailInteractorInputProtocol {
    var presenter: StudyDetailInteractorOutputProtocol?
    var localDatamanager: StudyDetailLocalDataManagerInputProtocol?
    var remoteDatamanager: StudyDetailRemoteDataManagerInputProtocol?
    
    func retrieveStudyDetail(keyValue: String) {
        remoteDatamanager?.getStudyDetail(keyValue: keyValue, completionHandler: {
            self.presenter?.didRetrieveStudyDetail($0)
        })
    }
    func postStudyJoin(studyID: Int, message: String) {
        remoteDatamanager?.postStudyJoin(studyID: studyID, message: message, completion: { result, message in
            switch result {
            case true:
                break
            case false:
                break
            }
        })
    }
}

extension StudyDetailInteractor: StudyDetailRemoteDataManagerOutputProtocol {
    func onStudyDetailRetrieved(_ studyDetail: StudyDetail) {
        presenter?.didRetrieveStudyDetail(studyDetail)
    }
    
    func onError() {
        
    }
}
