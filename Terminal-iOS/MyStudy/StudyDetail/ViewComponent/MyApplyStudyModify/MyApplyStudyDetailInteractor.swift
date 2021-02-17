//
//  MyApplyStudyModifyInteractor.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/11.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

class MyApplyStudyModifyInteractor: MyApplyStudyModifyInteractorInputProtocol {
    weak var presenter: MyApplyStudyModifyInteractorOutputProtocol?
    var remoteDataManager: MyApplyStudyModifyRemoteDataManagerInputProtocol?
    var applyID: Int?
    var studyID: Int?
    
    func getMyApplyStudyDetail(studyID: Int) {
        self.studyID = studyID
        guard let userID = KeychainWrapper.standard.string(forKey: "userID") else { return }
        remoteDataManager?.getMyApplyStudyDetail(studyID: studyID, userID: Int(userID)!)
    }
    
    func putNewApplyMessage(newMessage: String) {
        if let sID = studyID, let aID = applyID {
            remoteDataManager?.putNewApplyMessage(studyID: sID, applyID: aID, newMessage: newMessage)
        }
    }
}

extension MyApplyStudyModifyInteractor: MyApplyStudyModifyRemoteDataManagerOutputProtocol {
    
    func retriveMyApplyStudyDetail(result: Bool, data: ApplyUserResult? = nil, message: String? = nil) {
        switch result {
        case true:
            guard let applyUserInfo = data else { return }
            applyID = applyUserInfo.id
            let message = applyUserInfo.message
            presenter?.retriveMyApplyStudyDetail(result: result, message: message)
        case false:
            guard let message = message else { return }
            presenter?.retriveMyApplyStudyDetail(result: result, message: message)
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
