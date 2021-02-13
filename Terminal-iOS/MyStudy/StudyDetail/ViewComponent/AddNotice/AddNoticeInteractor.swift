//
//  AddNoticeInteractor.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/27.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

class AddNoticeInteractor: AddNoticeInteractorProtocol {
    weak var presenter: AddNoticePresenterProtocol?
    var remoteDataManager: AddNoticeRemoteDataManagerProtocol?
    var localDataManager: AddNoticeLocalDataManagerProtocol?
    
    func postNotice(studyID: Int, notice: NoticePost, state: AddNoticeState, noticeID: Int?) {
        
        if state == .edit {
            remoteDataManager?.putNotice(studyID: studyID,
                                         notice: notice,
                                         noticeID: noticeID!,
                                         completion: { _, notice in
                                            self.presenter?.addNoticeValid(notice: notice, studyID: studyID)
                                         })
        } else if state == .new {
            remoteDataManager?.postNotice(studyID: studyID,
                                          notice: notice,
                                          completion: { result in
                                            switch result.result {
                                            case true:
                                                self.presenter?.addNoticeValid(notice: result.data!.noticeID,
                                                                                studyID: studyID)
                                            case false:
                                                self.presenter?.addNoticeInvalid(message: result.message!)
                                            }
                                          })
        } else {
            print("addnoticestate값 지정 안됨")
        }
    }
}
