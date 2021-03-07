//
//  MyStudyDetailPresenter.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/24.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

final class MyStudyDetailPresenter: MyStudyDetailPresenterProtocol {
    
    weak var view: MyStudyDetailViewProtocol?
    var interactor: MyStudyDetailInteractorProtocol?
    var wireFrame: MyStudyDetailWireFrameProtocol?
        
    func addNoticeButtonDidTap(studyID: Int) {
        wireFrame?.goToAddNotice(studyID: studyID, parentView: view!)
    }
    
    func editStudyButtonDidTap(study: StudyDetail, location: Location, mainImage: UIImage?) {
        wireFrame?.goToEditStudy(study: study, location: location, parentView: view!)
    }
    
    func addNoticeFinished(notice: Int, studyID: Int, title: String) {
        wireFrame?.goToNoticeDetail(notice: notice, studyID: studyID, title: title, parentView: view!)
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
    
    func sessionTaskError(message: String) {
        view?.hideLoading()
        view?.showError(message: message)
    }
}
