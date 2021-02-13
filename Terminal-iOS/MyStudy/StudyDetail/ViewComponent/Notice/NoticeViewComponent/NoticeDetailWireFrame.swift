//
//  NoticeDetailWireFrame.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/12/01.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class NoticeDetailWireFrame: NoticeDetailWireFrameProtocol {    
    static func createNoticeDetailModule(notice: Int, studyID: Int?, title: String, parentView: UIViewController?, state: StudyDetailViewState) -> UIViewController {
        let view = NoticeDetailView()
        let presenter: NoticeDetailPresenterProtocol & NoticeDetailInteractorOutputProtocol = NoticeDetailPresenter()
        let interactor: NoticeDetailInteractorInputProtocol & NoticeDetailRemoteDataManagerOutputProtocol = NoticeDetailInteractor()
        let remoteDataManager = NoticeDetailRemoteDataManager()
        let wireFrame = NoticeDetailWireFrame()
        
        let newNotice = Notice(id: notice,
                               title: nil,
                               contents: nil,
                               leaderID: nil,
                               studyID: studyID,
                               pinned: nil,
                               updatedAt: nil,
                               leaderImage: nil,
                               leaderNickname: nil,
                               createAt: nil)
        view.presenter = presenter
        view.notice = newNotice
        view.parentView = parentView != nil ? parentView : nil
        view.state = state
        view.title = title
        
        if studyID != nil {
            view.notice?.studyID = studyID
        }
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        interactor.remoteDataManager = remoteDataManager
        
        remoteDataManager.interactor = interactor
        return view
    }
    
    func goToNoticeEdit(state: AddNoticeState,
                        notice: Notice,
                        parentView: NoticeDetailViewProtocol) {
        guard let parentView = parentView as? UIViewController else { return }
        let view = AddNoticeWireFrame.createAddNoticeModule(studyID: notice.studyID!,
                                                            notice: notice,
                                                            parentView: parentView,
                                                            state: state)
        parentView.present(view, animated: true)
    }
}
