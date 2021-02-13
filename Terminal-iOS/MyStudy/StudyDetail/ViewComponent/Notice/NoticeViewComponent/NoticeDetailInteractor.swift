//
//  NoticeDetailInteractor.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/12/01.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

class NoticeDetailInteractor: NoticeDetailInteractorInputProtocol {
    weak var presenter: NoticeDetailInteractorOutputProtocol?
    var remoteDataManager: NoticeDetailRemoteDataManagerInputProtocol?
    
    func getNoticeDetail(notice: Notice) {
        remoteDataManager?.getNoticeDetail(studyID: notice.studyID!, noticeID: notice.id)
    }
    
    func postNoticeRemove(notice: Notice) {
        remoteDataManager?.postNoticeRemove(studyID: notice.studyID!, noticeID: notice.id)
    }
}

extension NoticeDetailInteractor: NoticeDetailRemoteDataManagerOutputProtocol {
    func getNoticeDetailSuccess(notice: Notice) {
        presenter?.getNoticeDetailSuccess(notice: notice)
    }
    
    func getNoticeDetailFailure(message: String) {
        presenter?.getNoticeDetailFailure(message: message)
    }
    
    func removeNoticeDetailResult(result: BaseResponse<String>) {
        if let message = result.message {
            presenter?.removeNoticeResult(result: result.result, message: message)
        }
    }
}
