//
//  NoticeInteractor.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/25.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class NoticeInteractor: NoticeInteractorProtocol {
    var resultNoticeList: [Notice] = []
    var nextNoticeID: [Int] = []
    var presenter: NoticePresenterProtocol?
    var remoteDataManager: NoticeRemoteDataManagerProtocol?
    var localDataManager: NoticeLocalDataManagerProtocol?
    
    func getNoticeList(studyID: Int) {
        resultNoticeList.removeAll()
        nextNoticeID.removeAll()
        remoteDataManager?.getNoticeList(studyID: studyID, completion: { [self] (result, noticeList, message)  in
            switch result {
            case true:
                noticeList?.forEach {
                    $0.title != nil ? resultNoticeList.append($0) : nextNoticeID.append($0.id)
                }
                presenter?.showResult(result: result, noticeList: resultNoticeList, message: nil )
                break
            case false:
                presenter?.showResult(result: result, noticeList: nil, message: message! )
                break
            }
        })
    }
    func getNoticeListPagination(studyID: Int) {
        var nextNoticeListIDs: [Int] = []
        if nextNoticeID.count > 9 {
            nextNoticeListIDs = Array(nextNoticeID[0...9])
            nextNoticeID.removeSubrange(Range(0...9))
        } else {
            nextNoticeListIDs = nextNoticeID
            nextNoticeID.removeAll()
        }
        if nextNoticeListIDs.count > 0 {
            remoteDataManager?.getNoticeListPagination(studyID: studyID, noticeListIDs: nextNoticeListIDs, completion: { result, data, message in
                switch result {
                case true:
                    self.presenter?.showNoticePaginationResult(result: result, notice: data, message: nil)
                    break
                case false:
                    self.presenter?.showNoticePaginationResult(result: result, notice: nil, message: message)
                    break
                }
            })
        }
    }
}
