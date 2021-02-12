//
//  NoticeWireFrame.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/25.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class NoticeWireFrame: NoticeWireFrameProtocol {
    static func createNoticeModule(studyID: Int) -> UIViewController {
        let view = NoticeView()
        let presenter: NoticePresenterProtocol & NoticeInteractorOutputProtocol = NoticePresenter()
        let interactor = NoticeInteractor()
        let remoteDataManager = NoticeRemoteDataManager()
        let wireFrame = NoticeWireFrame()
        
        view.presenter = presenter
        view.studyID = studyID
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.remoteDataManager = remoteDataManager
        
        return view
    }
    
    func goToNoticeDetail(notice: Notice, parentView: UIViewController, state: StudyDetailViewState) {
        let view = NoticeDetailWireFrame.createNoticeDetailModule(notice: notice.id,
                                                                  studyID: notice.studyID,
                                                                  title: notice.title!,
                                                                  parentView: parentView,
                                                                  state: state)
        parentView.navigationController?.pushViewController(view, animated: true)
    }
}
