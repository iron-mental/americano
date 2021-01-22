//
//  NoticePresenter.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/25.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class NoticePresenter: NoticePresenterProtocol {
    
    var view: NoticeViewProtocol?
    var wireFrame: NoticeWireFrameProtocol?
    var interactor: NoticeInteractorProtocol?
    
    func viewDidLoad(studyID: Int) {
        view?.showLoading()
        interactor?.getNoticeList(studyID: studyID)
    }
    func showResult(result: Bool, noticeList: [Notice]?, message: String?) {
        switch result {
        case true:
            view?.showNoticeList(noticeList: noticeList!)
            break
        case false:
            view?.showMessage(message: message!)
            break
        }
    }
    
    func celldidTap(notice: Notice, parentView: UIViewController, state: StudyDetailViewState) {
        wireFrame?.goToNoticeDetail(notice: notice, parentView: parentView, state: state)
    }
    
//    func noticeDetailResult(result: Bool, notice: Notice, parentView: UIViewController) {
//        switch result {
//        case true:
////            wireFrame?.goToNoticeDetail(notice: notice, parentView: parentView, state: state)
//        case false:
//            print("실패니까 대처해 얼릉")
//        }
//    }
    func didScrollEnded(studyID: Int) {
        
        interactor?.getNoticeListPagination(studyID: studyID)
    }
    
    func showNoticePaginationResult(result: Bool, notice: [Notice]?, message: String?) {
        switch result {
        case true:
            view?.showNoticeList(noticeList: notice!)
            break
        case false:
            break
        }
        
    }
}
