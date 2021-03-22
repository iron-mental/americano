//
//  MyStudyDetailInteractor.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/24.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

final class MyStudyDetailInteractor: MyStudyDetailInteractorProtocol {
    weak var presenter: MyStudyDetailPresenterProtocol?
    var remoteDatamanager: MyStudyDetailRemoteDataManagerProtocol?
    var localDatamanager: MyStudyDetailLocalDataManagerProtocol?
    
    func postLeaveStudyAPI(studyID: Int) {
        remoteDatamanager?.postLeaveStudyAPI(studyID: studyID)
    }
    
    func callDeleteStudyAPI(studyID: Int) {
        remoteDatamanager?.callDeleteStudyAPI(studyID: studyID)
    }
    
    func leaveStudyResult(result: Bool, message: String) {
        presenter?.leaveStudyResult(result: result, message: message)
    }
    
    func deleteStudyResult(result: Bool, message: String) {
        presenter?.deleteStudyResult(result: result, message: message)
    }
    
    func sessionTaskError(message: String) {
        presenter?.sessionTaskError(message: message)
    }
}
