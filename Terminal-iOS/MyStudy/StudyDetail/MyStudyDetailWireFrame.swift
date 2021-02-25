//
//  MyStudyDetailWireFrame.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/24.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

final class MyStudyDetailWireFrame: MyStudyDetailWireFrameProtocol {    
    static func createMyStudyDetailModule(studyID: Int, studyTitle: String) -> UIViewController {
        let view: MyStudyDetailViewProtocol = MyStudyDetailView()
        let presenter: MyStudyDetailPresenterProtocol = MyStudyDetailPresenter()
        let interactor: MyStudyDetailInteractorProtocol = MyStudyDetailInteractor()
        let remoteDataManager: MyStudyDetailRemoteDataManagerProtocol = MyStudyDetailRemoteDataManager()
        let localDataManager: MyStudyDetailLocalDataManagerProtocol = MyStudyDetailLocalManager()
        let wireFrame: MyStudyDetailWireFrameProtocol = MyStudyDetailWireFrame()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireFrame = wireFrame
        interactor.presenter = presenter
        interactor.remoteDatamanager = remoteDataManager
        interactor.localDatamanager = localDataManager
        remoteDataManager.interactor = interactor
        
        if let view = view as? MyStudyDetailView {
            view.hidesBottomBarWhenPushed = true
            view.studyTitle = studyTitle
            view.studyID = studyID
            return view
        } else {
            return UIViewController()
        }
    }
    
    func goToAddNotice(studyID: Int, parentView: MyStudyDetailViewProtocol) {
        if let sourceView = parentView as? UIViewController {
            let view = AddNoticeWireFrame.createAddNoticeModule(studyID: studyID,
                                                                notice: nil,
                                                                parentView: sourceView,
                                                                state: .new)
            sourceView.present(view, animated: true)
        }
    }
    
    func goToEditStudy(study: StudyDetail, location: Location, parentView: MyStudyDetailViewProtocol) {
        if let sourceView = parentView as? UIViewController {
            let view = ModifyStudyWireFrame.createModifyStudyModule(study: study, location: location)
            sourceView.navigationController?.pushViewController(view, animated: true)
        }
    }
    
    func goToNoticeDetail(notice: Int, studyID: Int, title: String, parentView: MyStudyDetailViewProtocol) {
        if let sourceView = parentView as? UIViewController {
            let view = NoticeDetailWireFrame.createNoticeDetailModule(notice: notice,
                                                                      studyID: studyID,
                                                                      title: title,
                                                                      parentView: sourceView,
                                                                      state: .host)
            sourceView.navigationController?.pushViewController(view, animated: true)
        }
    }
    
    func goToApplyUser(from view: MyStudyDetailViewProtocol, studyID: Int) {
        let applyUserView = ApplyUserWireFrame.createUserListModule(studyID: studyID)
        
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(applyUserView, animated: true)
        }
    }
    
    func goToDelegateHost(from view: MyStudyDetailViewProtocol, studyID: Int, userList: [Participate]) {
        let delegateHostView = DelegateHostWireFrame.createDelegateHostmodule(studyID: studyID, userList: userList)
        
        if let parentView = view as? UIViewController {
            parentView.navigationController?.pushViewController(delegateHostView, animated: true)
        }
    }
}
