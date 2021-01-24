//
//  NoticeDetailInteractor.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/12/01.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

class NoticeDetailInteractor: NoticeDetailInteractorProtocol {
    var presenter: NoticeDetailPresenterProtocol?
    var remoteDataManager: NoticeDetailRemoteDataManagerProtocol?
    var localDataManager: NoticeDetailLocalDataManagerProtocol?
    
    func getNoticeDetail(notice: Notice) {
        remoteDataManager?.getNoticeDetail(studyID: notice.studyID!, noticeID: notice.id, completion: { result, notice in
            switch result {
            case true:
                self.presenter?.noticeDetailResult(result: result, notice: notice)
                break
            case false:
//
                break
            }
        })
    }
    
    func postNoticeRemove(notice: Notice) {
        remoteDataManager?.postNoticeRemove(studyID: notice.studyID!, noticeID: notice.id, completion: { result, message in
            switch result {
            case true:
                self.presenter?.noticeRemoveResult(result: result, message: message)
                break
            case false:
//                
                break
            }
        })
    }
}
