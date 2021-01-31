//
//  NoticeInteractor.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/25.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class NoticeInteractor: NoticeInteractorInputProtocol {
    var totalNoticeList: [Notice] = []
    var nextNoticeID: [Int] = []
    var firstNoticeList: [Notice] = []
    var secondNoticeList: [Notice] = []
    
    var presenter: NoticeInteractorOutputProtocol?
    var remoteDataManager: NoticeRemoteDataManagerProtocol?
    
    func getNoticeList(studyID: Int) {
        totalNoticeList.removeAll()
        nextNoticeID.removeAll()
        
        remoteDataManager?.getNoticeList(studyID: studyID, completion: { result, noticeList, message in
            
            
            switch result {
            case true:
                noticeList?.forEach {
                    //이 부분 페이지네이션 관련 컬럼이 추가됐는지 안됐는지 확인하고 그걸로 분기
                    $0.title != nil ? self.totalNoticeList.append($0) : self.nextNoticeID.append($0.id)
                }
                let sortedNoticeList = self.sorted()
                if sortedNoticeList.count == 0 {
                    self.presenter?.showResult(result: result, firstNoticeList: [], secondNoticeList: [], message: "조회된 공지사항이 없습니다.")
                } else if sortedNoticeList.count == 2 {
                    self.presenter?.showResult(result: result, firstNoticeList: sortedNoticeList[0], secondNoticeList: sortedNoticeList[1], message: message)
                } else if sortedNoticeList.count == 1 {
                    self.presenter?.showResult(result: result, firstNoticeList: sortedNoticeList[0], secondNoticeList: [], message: message)
                }
            case false:
                guard let msg = message else { return }
                self.presenter?.showError(message: msg)
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
            remoteDataManager?.getNoticeListPagination(studyID: studyID, noticeListIDs: nextNoticeListIDs, completion: { result, noticeList, message in
                switch result {
                case true:
                    noticeList?.forEach({
                        self.totalNoticeList.append($0)
                    })
                    let sortedNoticeList = self.sorted()
                    if sortedNoticeList.count == 0 {
                        self.presenter?.showResult(result: result, firstNoticeList: [], secondNoticeList: [], message: "조회된 공지사항이 없습니다.")
                    } else if sortedNoticeList.count == 2 {
                        self.presenter?.showResult(result: result, firstNoticeList: sortedNoticeList[0], secondNoticeList: sortedNoticeList[1], message: message)
                    } else if sortedNoticeList.count == 1 {
                        self.presenter?.showResult(result: result, firstNoticeList: sortedNoticeList[0], secondNoticeList: [], message: message)
                    }
                case false:
                    guard let msg = message else { return }
                    self.presenter?.showError(message: msg)
                }
            })
        }
    }
    
    func sorted() -> [[Notice]] {
        var noticeListQueue: [[Notice]] = []
        var pinnedNotiArr: [Notice] = []
        var commonNotiArr: [Notice] = []
        pinnedNotiArr = totalNoticeList.filter { $0.pinned! }
        commonNotiArr = totalNoticeList.filter { !$0.pinned! }
        pinnedNotiArr.isEmpty ? () : noticeListQueue.append(pinnedNotiArr)
        commonNotiArr.isEmpty ? () : noticeListQueue.append(commonNotiArr)
        
        if !totalNoticeList.isEmpty {
            if !noticeListQueue[0].isEmpty {
                firstNoticeList = noticeListQueue[0]
            }
            if noticeListQueue.count == 2 {
                if !noticeListQueue[1].isEmpty {
                    secondNoticeList = noticeListQueue[1]
                }
            }
        }
        
        return noticeListQueue
    }
}
