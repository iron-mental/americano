//
//  AddNoticePresenter.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/27.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class AddNoticePresenter: AddNoticePresenterProtocol {
    var view: AddNoticeViewProtocol?
    var wireFrame: AddNoticeWireFrameProtocol?
    var interactor: AddNoticeInteractorProtocol?
    
    func completeButtonDidTap(studyID: Int, notice: NoticePost, state: AddNoticeState, noticeID: Int?) {
        interactor?.postNotice(studyID: studyID, notice: notice, state: state, noticeID: noticeID ?? nil)
    }
    
    func addNoticeResult(result: Bool, notice: Int, studyID: Int) {
        if result {
            view?.showNewNotice()
            wireFrame?.goToNoticeDetailView(noticeID: notice, studyID: studyID, parentView: UIViewController())
        } else {
        }
    }
}
