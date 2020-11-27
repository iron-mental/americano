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
        interactor?.getNoticeList(studyID: studyID)
    }
    func showResult(result: Bool, noticeList: NoticeList?, message: String?) {
        switch result {
        case true:
            view?.showNoticeList(noticeList: noticeList!)
            break
        case false:
            view?.showMessage(message: message!)
            break
        }
    }
    func celldidTap(notice: Notice, parentView: UIViewController) {
        interactor?.getNoticeDetail(notice: notice, parentView: parentView)
    }
    
    func noticeDetailResult(result: Bool, notice: Notice, parentView: UIViewController) {
        switch result {
        case true:
            wireFrame?.goToNoticeDetail(notice: notice, parentView: parentView)
        case false:
            print("실패니까 대처해 얼릉")
        }
    }
}
