//
//  NoticeDetailPresenter.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/12/01.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class NoticeDetailPresenter: NoticeDetailPresenterProtocol {
    weak var view: NoticeDetailViewProtocol?
    var interactor: NoticeDetailInteractorInputProtocol?
    var wireFrame: NoticeDetailWireFrameProtocol?
    
    func viewDidLoad(notice: Notice) {
        view?.showLoading()
        interactor?.getNoticeDetail(notice: notice)
    }
    
    func removeButtonDidTap(notice: Notice) {
        view?.showLoading()
        interactor?.postNoticeRemove(notice: notice)
    }
    
    func modifyButtonDidTap(state: AddNoticeState,
                            notice: Notice,
                            parentView: NoticeDetailViewProtocol) {
        view?.showLoading()
        wireFrame?.goToNoticeEdit(state: state, notice: notice, parentView: parentView)
    }
    
}

extension NoticeDetailPresenter: NoticeDetailInteractorOutputProtocol {
    func getNoticeDetailSuccess(notice: Notice) {
        view?.hideLoading()
        view?.showNoticeDetail(notice: notice)
    }
    func getNoticeDetailFailure(message: String) {
        view?.hideLoading()
        view?.showError(message: message)
    }
    func removeNoticeResult(result: Bool, message: String) {
        view?.hideLoading()
        switch result {
        case true:
            view?.showNoticeRemove(message: message)
        case false:
            view?.showError(message: message)
        }
    }
}
