//
//  MyApplyStudyModifyInteractor.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/11.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation

class MyApplyStudyModifyInteractor: MyApplyStudyModifyInteractorInputProtocol {
    weak var presenter: MyApplyStudyModifyInteractorOutputProtocol?
    var remoteDataManager: MyApplyStudyModifyRemoteDataManagerInputProtocol?
    var applyID: Int?
    var studyID: Int?
    
    func getMyApplyStudyDetail(studyID: Int) {
        self.studyID = studyID
        
        if let userInfo = CoreDataManager.shared.getUserinfo() {
            remoteDataManager?.getMyApplyStudyDetail(studyID: studyID, userID: userInfo.id)
        }
        
    }
    
    func putNewApplyMessage(newMessage: String) {
        if let sID = studyID, let aID = applyID {
            remoteDataManager?.putNewApplyMessage(studyID: sID, applyID: aID, newMessage: newMessage)
        }
    }
}

extension MyApplyStudyModifyInteractor: MyApplyStudyModifyRemoteDataManagerOutputProtocol {
    func retriveMyApplyStudyDetailFailed(message: String) {
//        <#code#>
    }
    
    func retriveMyApplyStudyDetail(result: Bool, data: ApplyUserResult) {
        
        switch result {
        case true:
            applyID = data.id
            let message = data.message
            presenter?.retriveMyApplyStudyDetail(result: result, message: message)
        case false:
            presenter?.retriveMyApplyStudyDetail(result: result, message: data.message)
        }
    }
    
    func retriveModifyApplyMessage(result: Bool, message: String) {
        switch result {
        case true:
            presenter?.retriveModifyApplyMessage(result: result, message: message)
        case false:
            presenter?.retriveModifyApplyMessage(result: result, message: message)
        }
    }
}
