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
    func getNoticeDetailResult(result: BaseResponse<Notice>) {
        switch result.result {
        case true:
            guard let notice = result.data else { return }
            presenter?.getNoticeDetailSuccess(notice: notice)
        case false:
            guard let message = result.message else { return }
            presenter?.getNoticeDetailFailure(message: message)
        }
    }
    
    func removeNoticeDetailResult(result: BaseResponse<String>) {
        if let message = result.message {
            presenter?.removeNoticeResult(result: result.result, message: message)
        }
    }
}
