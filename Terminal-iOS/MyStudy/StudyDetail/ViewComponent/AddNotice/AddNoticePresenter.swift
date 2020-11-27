//
//  AddNoticePresenter.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/27.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

class AddNoticePresenter: AddNoticePresenterProtocol {
    var view: AddNoticeViewProtocol?
    var wireFrame: AddNoticeWireFrameProtocol?
    var interactor: AddNoticeInteractorProtocol?
    
    func completeButtonDidTap(studyID: Int, notice: NoticePost) {
        interactor?.postNotice(studyID: studyID, notice: notice)
    }
    
    func addNoticeResult(result: Bool, notice: String) {
        if result {
            view?.showNewNotice()
        } else {
            print("에러 처리해라")
        }
    }
}
