//
//  NoticeDetailWireFrame.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/12/01.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class NoticeDetailWireFrame: NoticeDetailWireFrameProtocol {
    var presenter: NoticeDetailPresenterProtocol?
    
    static func createNoticeDetailModule(notice: Int, studyID: Int?, parentView: UIViewController?) -> UIViewController {
        var view = NoticeDetailView()
        let presenter = NoticeDetailPresenter()
        let interactor = NoticeDetailInteractor()
        let remoteDataManager = NoticeDetailRemoteDataManager()
        let localDataManager = NoticeDetailLocalDataManager()
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
        view.parentView = parentView != nil ? (parentView as! NoticeViewProtocol) : nil
        if studyID != nil {
            view.notice?.studyID = studyID
        }
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        interactor.remoteDataManager = remoteDataManager
        interactor.localDataManager = localDataManager
        
        wireFrame.presenter = presenter
        
        return view
    }
}
