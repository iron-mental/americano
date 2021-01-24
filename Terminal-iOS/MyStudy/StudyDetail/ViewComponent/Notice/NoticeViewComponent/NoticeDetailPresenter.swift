//
//  NoticeDetailPresenter.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/12/01.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class NoticeDetailPresenter: NoticeDetailPresenterProtocol {
    
    
    
    var view: NoticeDetailViewProtocol?
    var interactor: NoticeDetailInteractorProtocol?
    var wireFrame: NoticeDetailWireFrameProtocol?
    
    func viewDidLoad(notice: Notice) {
        interactor?.getNoticeDetail(notice: notice)
    }
    
    func noticeDetailResult(result: Bool, notice: Notice) {
        switch result {
        case true:
            view?.showNoticeDetail(notice: notice)
            break
        case false:
            view?.showError(message: "권한이 없습니다.")
            break
        }
    }
    func removeButtonDidTap(notice: Notice) {
        interactor?.postNoticeRemove(notice: notice)
    }
    
    func modifyButtonDidTap(state: AddNoticeState, notice: Notice, parentView: NoticeDetailViewProtocol) {
        wireFrame?.goToNoticeEdit(state: state, notice: notice, parentView: parentView)
    }
    
    func noticeRemoveResult(result: Bool, message: String) {
        view?.showNoticeRemove(message: message)
    }
}
