//
//  NoticeDetailPresenter.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/12/01.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

class NoticeDetailPresenter: NoticeDetailPresenterProtocol {
    var view: NoticeDetailViewProtocol?
    var interactor: NoticeDetailInteractorProtocol?
    var wireFrame: NoticeDetailWireFrameProtocol?
    
    func viewDidLoad(notice: Notice) {
        interactor?.getNoticeDetail(notice: notice)
    }
    
    func noticeDetailResult(result: Bool, notice: Notice) {
        view?.showNoticeDetail(notice: notice)
    }
}
