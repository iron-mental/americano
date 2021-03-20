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
    var studyID: Int?
    
    func postLeaveStudyAPI(studyID: Int) {
        self.studyID = studyID
        remoteDatamanager?.postLeaveStudyAPI(studyID: studyID)
    }
    
    func callDeleteStudyAPI(studyID: Int) {
        self.studyID = studyID
        remoteDatamanager?.callDeleteStudyAPI(studyID: studyID)
    }
    
    func leaveStudyResult(result: Bool, message: String) {
        switch result {
        case true:
            guard let id = self.studyID else { return }
            CoreDataManager.shared.removeChat(studyID: id)
        case false: break
        }
        presenter?.leaveStudyResult(result: result, message: message)
    }
    
    func deleteStudyResult(result: Bool, message: String) {
        switch result {
        case true:
            guard let id = self.studyID else { return }
            CoreDataManager.shared.removeChat(studyID: id)
        case false: break
        }
        presenter?.deleteStudyResult(result: result, message: message)
    }
    
    func sessionTaskError(message: String) {
        presenter?.sessionTaskError(message: message)
    }
}
