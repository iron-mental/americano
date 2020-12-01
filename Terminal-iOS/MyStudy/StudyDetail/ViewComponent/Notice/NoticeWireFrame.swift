//
//  NoticeWireFrame.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/25.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class NoticeWireFrame: NoticeWireFrameProtocol {
    var presenter: NoticePresenterProtocol?
    
    static func createNoticeModule(studyID: Int) -> UIViewController {
        let view = NoticeView()
        let presenter = NoticePresenter()
        let interactor = NoticeInteractor()
        let remoteDataManager = NoticeRemoteDataManager()
        let localDataManager = NoticeLocalDataManager()
        let wireFrame = NoticeWireFrame()
        
        view.presenter = presenter
        view.studyID = studyID
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.remoteDataManager = remoteDataManager
        interactor.localDataManager = localDataManager
        wireFrame.presenter = presenter
        
        return view
    }
    func goToNoticeDetail(notice: Notice, parentView: UIViewController) {
        let view = NoticeDetailWireFrame.createNoticeDetailModule(notice: notice.id, studyID: notice.studyID)
        parentView.present(view , animated: true) {
//
        }
    }
}
