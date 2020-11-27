//
//  NoticeInteractor.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/25.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class NoticeInteractor: NoticeInteractorProtocol {
    
    
    var presenter: NoticePresenterProtocol?
    var remoteDataManager: NoticeRemoteDataManagerProtocol?
    var localDataManager: NoticeLocalDataManagerProtocol?
    
    func getNoticeList(studyID: Int) {
        remoteDataManager?.getNoticeList(studyID: studyID, completion: { [self] (result, noticeList, message)  in
            switch result {
            case true:
                presenter?.showResult(result: result, noticeList: noticeList!, message: nil )
                break
            case false:
                presenter?.showResult(result: result, noticeList: nil, message: message! )
                break
            }
        })
    }
    func getNoticeDetail(notice: Notice, parentView: UIViewController) {
        print(notice)
        let studyID = notice.studyID
        let noticeID = notice.id
        remoteDataManager?.getNoticeDetail(studyID: studyID!, noticeID: noticeID, completion: { result, data in
            self.presenter?.noticeDetailResult(result: result, notice: data, parentView: parentView)
        })
    }
}
