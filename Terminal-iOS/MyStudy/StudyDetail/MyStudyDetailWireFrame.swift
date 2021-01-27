//
//  MyStudyDetailWireFrame.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/24.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class MyStudyDetailWireFrame: MyStudyDetailWireFrameProtocol {
    var presenter: MyStudyDetailPresenterProtocol?
    
    static func createMyStudyDetailModule(studyID: Int) -> UIViewController {
        let view: MyStudyDetailViewProtocol = MyStudyDetailView()
        let presenter: MyStudyDetailPresenterProtocol = MyStudyDetailPresenter()
        let interactor: MyStudyDetailInteractorProtocol = MyStudyDetailInteractor()
        let remoteDataManager: MyStudyDetailRemoteDataManagerProtocol = MyStudyDetailRemoteDataManager()
        let localDataManager: MyStudyDetailLocalDataManagerProtocol = MyStudyDetailLocalManager()
        let wireFrame: MyStudyDetailWireFrameProtocol = MyStudyDetailWireFrame()
        
        view.presenter = presenter
        view.studyID = studyID
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireFrame = wireFrame
        interactor.presenter = presenter
        interactor.remoteDatamanager = remoteDataManager
        interactor.localDatamanager = localDataManager
        remoteDataManager.interactor = interactor
        wireFrame.presenter = presenter
        
        if let view = view as? MyStudyDetailView {
            return view
        } else {
            return UIViewController()
        }
    }
    
    func goToAddNotice(studyID: Int, parentView: UIViewController) {
        let view = AddNoticeWireFrame.createAddNoticeModule(studyID: studyID, notice: nil, parentView: parentView, state: .new)
        parentView.present(view, animated: true)
    }
    
    func goToEditStudy(study: StudyDetail, parentView: UIViewController) {
        let view = ModifyStudyWireFrame.createModifyStudyModule(study: study, parentView: parentView)
        parentView.navigationController?.pushViewController(view, animated: true)
//        parentView.present(view, animated: true)
    }
    
    func goToNoticeDetail(notice: Int, studyID: Int, parentView: UIViewController) {
        let view = NoticeDetailWireFrame.createNoticeDetailModule(notice: notice, studyID: studyID, parentView: parentView, state: .host)
        parentView.present(view, animated: true)
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
