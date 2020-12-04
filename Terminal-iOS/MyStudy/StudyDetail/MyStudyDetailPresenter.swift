//
//  MyStudyDetailPresenter.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/24.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class MyStudyDetailPresenter: MyStudyDetailPresenterProtocol {
    var view: MyStudyDetailViewProtocol?
    var interactor: MyStudyDetailInteractorProtocol?
    var wireFrame: MyStudyDetailWireFrameProtocol?
        
    func addNoticeButtonDidTap(studyID: Int, parentView: UIViewController) {
        wireFrame?.goToAddNotice(studyID: studyID, parentView: parentView)
    }
    
    func editStudyButtonDidTap(study: StudyDetail, parentView: UIViewController) {
        wireFrame?.goToEditStudy(study: study, parentView: parentView)
    }
    
    func addNoticeFinished(notice: Int, studyID: Int, parentView: UIViewController) {
        wireFrame?.goToNoticeDetail(notice: notice, studyID: studyID, parentView: parentView)
    }
}
