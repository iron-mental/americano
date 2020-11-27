//
//  AddNoticeInteractor.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/27.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

class AddNoticeInteractor: AddNoticeInteractorProtocol {
    var presenter: AddNoticePresenterProtocol?
    var remoteDataManager: AddNoticeRemoteDataManagerProtocol?
    var localDataManager: AddNoticeLocalDataManagerProtocol?
    
    func postNotice(studyID: Int, notice: NoticePost) {
        remoteDataManager?.postNotice(studyID: studyID, notice: notice, completion: { result, message in
            
            self.presenter?.addNoticeResult(result: result, notice: message)
        })
    }
}
