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
        var view = NoticeDetailView() as NoticeDetailViewProtocol
        
        view.notice = notice
        
//        view.noticeTitle.text = notice.title
//        view.noticeDate.text = notice.createdAt
//        view.noticeID = notice.id
//        view.noticeContents.text = notice.contents
//        view.profileName.text = "방장이름"
//        view.noticeBackground.backgroundColor = notice.pinned ? UIColor.appColor(.pinnedNoticeColor) : UIColor.appColor(.noticeColor)
//        view.noticeLabel.text = notice.pinned ? "필독" : "공지"
//        얘는 쓸데가 더있을 듯 분명히
//        notice.studyID
//        view.modalPresentationStyle = .fullScreen
        parentView.present(view as! UIViewController, animated: true) {
//            나중에 쓰겠죠
        }
    }
}
