//
//  AddNoticeWireFrame.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/27.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class AddNoticeWireFrame: AddNoticeWireFrameProtocol {
    var presenter: AddNoticePresenterProtocol?
    
    static func createAddNoticeModule(studyID: Int, parentView: UIViewController) -> UIViewController {
        let view = AddNoticeView()
        let presenter = AddNoticePresenter()
        let interactor = AddNoticeInteractor()
        let remoteDataManager = AddNoticeRemoteDataManager()
        let localDataManager = AddNoticeLocalDataManager()
        let wireFrame = AddNoticeWireFrame()
        
        view.presenter = presenter
        view.studyID = studyID
        print(parentView)
        view.parentView = parentView != nil ? (parentView as! NoticeViewProtocol) : nil
        
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.remoteDataManager = remoteDataManager
        interactor.localDataManager = localDataManager
        wireFrame.presenter = presenter
        
        return view
    }
    func goToNoticeDetailView(noticeID: Int, studyID: Int, parentView: UIViewController?) {
        let view = NoticeDetailWireFrame.createNoticeDetailModule(notice: noticeID, studyID: studyID, parentView: nil)
        
    }
}
