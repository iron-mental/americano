//
//  NoticePresenter.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/25.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class NoticePresenter: NoticePresenterProtocol {
    weak var view: NoticeViewProtocol?
    var wireFrame: NoticeWireFrameProtocol?
    var interactor: NoticeInteractorInputProtocol?
    
    func viewDidLoad(studyID: Int) {
        interactor?.getNoticeList(studyID: studyID)
    }
    
    func celldidTap(notice: Notice, parentView: UIViewController, state: StudyDetailViewState) {
        view?.showLoading()
        wireFrame?.goToNoticeDetail(notice: notice, parentView: parentView, state: state)
    }
    
    func didScrollEnded(studyID: Int) {
        interactor?.getNoticeListPagination(studyID: studyID)
    }
}

extension NoticePresenter: NoticeInteractorOutputProtocol {
    func showResult(result: Bool, firstNoticeList: [Notice], secondNoticeList: [Notice]) {
        view?.showNoticeList(firstNoticeList: firstNoticeList, secondNoticeList: secondNoticeList)
    }
    
    func showError(message: String) {
        view?.showMessage(message: message)
    }
}
