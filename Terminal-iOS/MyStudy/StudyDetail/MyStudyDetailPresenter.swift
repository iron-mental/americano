//
//  MyStudyDetailPresenter.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/24.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class MyStudyDetailPresenter: MyStudyDetailPresenterProtocol {
    weak var view: MyStudyDetailViewProtocol?
    var interactor: MyStudyDetailInteractorProtocol?
    var wireFrame: MyStudyDetailWireFrameProtocol?
        
    func addNoticeButtonDidTap(studyID: Int, parentView: UIViewController) {
        wireFrame?.goToAddNotice(studyID: studyID, parentView: parentView)
    }
    
    func editStudyButtonDidTap(study: StudyDetail, parentView: UIViewController) {
        wireFrame?.goToEditStudy(study: study, parentView: parentView)
    }
    
    func addNoticeFinished(notice: Int, studyID: Int, title: String, parentView: UIViewController) {
        wireFrame?.goToNoticeDetail(notice: notice, studyID: studyID, title: title, parentView: parentView)
    }
    
    func showApplyUserList(studyID: Int) {
        wireFrame?.goToApplyUser(from: view!, studyID: studyID)
    }
    
    func leaveStudyButtonDidTap(studyID: Int) {
        view?.showLoading()
        interactor?.postLeaveStudyAPI(studyID: studyID)
    }
    
    func deleteStudyButtonDidTap(studyID: Int) {
        view?.showLoading()
        interactor?.callDeleteStudyAPI(studyID: studyID)
    }
    
    func leaveStudyResult(result: Bool, message: String) {
        if result {
            view?.showLeaveStudyComplete(message: message)
        } else {
            view?.showLeaveStudyFailed(message: message)
        }
    }
    
    func deleteStudyResult(result: Bool, message: String) {
        if result {
            view?.showDeleteStudyComplete(message: message)
        } else {
            view?.showDeleteStudyFailed(message: message)
        }
    }
    
    func delegateHostButtonDidTap(studyID: Int, userList: [Participate]) {
        wireFrame?.goToDelegateHost(from: view!, studyID: studyID, userList: userList)
    }
}
