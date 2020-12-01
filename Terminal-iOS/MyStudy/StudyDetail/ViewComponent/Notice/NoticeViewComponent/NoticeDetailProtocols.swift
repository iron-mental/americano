//
//  NoticeDetailProtocols.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/12/01.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

protocol NoticeDetailViewProtocol {
    var presenter: NoticeDetailPresenterProtocol? { get set }
    var notice: Notice? { get set }
    var parentView: NoticeViewProtocol? { get set }
    var noticeID: Int? { get set }
    
    //PRESENTER -> VIEW
    func showNoticeDetail(notice: Notice)
}

protocol NoticeDetailInteractorProtocol {
    var presenter: NoticeDetailPresenterProtocol? { get set }
    var remoteDataManager: NoticeDetailRemoteDataManagerProtocol? { get set }
    var localDataManager: NoticeDetailLocalDataManagerProtocol? { get set }
    
    func getNoticeDetail(notice: Notice)
}

protocol NoticeDetailPresenterProtocol {
    var view: NoticeDetailViewProtocol? { get set  }
    var interactor: NoticeDetailInteractorProtocol? { get set }
    var wireFrame: NoticeDetailWireFrameProtocol? { get set }
    
    //VIEW -> PRESENTER
    func viewDidLoad(notice: Notice)
    //INTERACTOR -> PRESENTER
    func noticeDetailResult(result: Bool, notice: Notice)
}

protocol NoticeDetailRemoteDataManagerProtocol {
    func getNoticeDetail(studyID: Int, noticeID: Int, completion: @escaping ( _ result: Bool, _ data: Notice) -> Void)
}

protocol NoticeDetailLocalDataManagerProtocol {
    
}

protocol NoticeDetailWireFrameProtocol {
    var presenter: NoticeDetailPresenterProtocol? { get set }
    
    static func createNoticeDetailModule( notice: Int, studyID: Int? ) -> UIViewController
}
