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
    func showNoticeRemove(message: String)
}

protocol NoticeDetailInteractorProtocol {
    var presenter: NoticeDetailPresenterProtocol? { get set }
    var remoteDataManager: NoticeDetailRemoteDataManagerProtocol? { get set }
    var localDataManager: NoticeDetailLocalDataManagerProtocol? { get set }
    
    //PRESENTER -> INTERACTOR
    func getNoticeDetail(notice: Notice)
    func postNoticeRemove(notice: Notice)
}

protocol NoticeDetailPresenterProtocol {
    var view: NoticeDetailViewProtocol? { get set  }
    var interactor: NoticeDetailInteractorProtocol? { get set }
    var wireFrame: NoticeDetailWireFrameProtocol? { get set }
    
    //VIEW -> PRESENTER
    func viewDidLoad(notice: Notice)
    func removeButtonDidTap(notice: Notice)
    func modifyButtonDidTap(state: AddNoticeState, notice: Notice)
    
    //INTERACTOR -> PRESENTER
    func noticeDetailResult(result: Bool, notice: Notice)
    func noticeRemoveResult(result: Bool, message: String)
}

protocol NoticeDetailRemoteDataManagerProtocol {
    func getNoticeDetail(studyID: Int, noticeID: Int, completion: @escaping ( _ result: Bool, _ data: Notice ) -> Void)
    func postNoticeRemove(studyID: Int, noticeID: Int, completion: @escaping ( _ result: Bool, _ message: String ) -> Void)
}


protocol NoticeDetailLocalDataManagerProtocol {
    
}

protocol NoticeDetailWireFrameProtocol {
    var presenter: NoticeDetailPresenterProtocol? { get set }
    
    static func createNoticeDetailModule( notice: Int, studyID: Int?, parentView: UIViewController? ) -> UIViewController
}
