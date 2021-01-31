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
    var interactor: NoticeInteractorInputProtocol?
    
    func viewDidLoad(studyID: Int) {
        view?.showLoading()
        interactor?.getNoticeList(studyID: studyID)
    }
    
    func celldidTap(notice: Notice, parentView: UIViewController, state: StudyDetailViewState) {
        wireFrame?.goToNoticeDetail(notice: notice, parentView: parentView, state: state)
    }
    
    func didScrollEnded(studyID: Int) {
        interactor?.getNoticeListPagination(studyID: studyID)
    }
}

extension NoticePresenter: NoticeInteractorOutputProtocol {
    func showResult(result: Bool, firstNoticeList: [Notice], secondNoticeList: [Notice], message: String?) {
        switch result {
        case true:
            view?.showNoticeList(firstNoticeList: firstNoticeList, secondNoticeList: secondNoticeList)
        case false:
            view?.showMessage(message: message!)
        }
    }
    
    func showNoticePaginationResult(result: Bool, firstNoticeList: [Notice], secondNoticeList: [Notice], message: String?) {
        switch result {
        case true:
            view?.showNoticeList(firstNoticeList: firstNoticeList, secondNoticeList: secondNoticeList)
        case false:
            break
        }
    }
    
    func showError(message: String) {
        
    }
}
