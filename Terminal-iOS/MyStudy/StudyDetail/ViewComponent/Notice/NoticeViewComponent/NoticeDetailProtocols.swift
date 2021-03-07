//
//  NoticeDetailProtocols.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/12/01.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

protocol NoticeDetailViewProtocol: class {
    var presenter: NoticeDetailPresenterProtocol? { get set }
    var notice: Notice? { get set }
    var parentView: UIViewController? { get set }
    
    //PRESENTER -> VIEW
    func showNoticeDetail(notice: Notice)
    func showNoticeRemove(message: String)
    func showError(message: String)
    
    func showLoading()
    func hideLoading()
}

protocol NoticeDetailPresenterProtocol: class {
    var view: NoticeDetailViewProtocol? { get set  }
    var interactor: NoticeDetailInteractorInputProtocol? { get set }
    var wireFrame: NoticeDetailWireFrameProtocol? { get set }
    
    //VIEW -> PRESENTER
    func viewDidLoad(notice: Notice)
    func removeButtonDidTap(notice: Notice)
    func modifyButtonDidTap(state: AddNoticeState,
                            notice: Notice,
                            parentView: NoticeDetailViewProtocol)
}

protocol NoticeDetailInteractorInputProtocol: class {
    var presenter: NoticeDetailInteractorOutputProtocol? { get set }
    var remoteDataManager: NoticeDetailRemoteDataManagerInputProtocol? { get set }
    
    //PRESENTER -> INTERACTOR
    func getNoticeDetail(notice: Notice)
    func postNoticeRemove(notice: Notice)
}

protocol NoticeDetailInteractorOutputProtocol: class {
    func getNoticeDetailSuccess(notice: Notice)
    func getNoticeDetailFailure(message: String)
    func removeNoticeResult(result: Bool, message: String)
    func sessionTaskError(message: String)
}

protocol NoticeDetailRemoteDataManagerInputProtocol: class {
    var interactor: NoticeDetailRemoteDataManagerOutputProtocol? { get set }
    func getNoticeDetail(studyID: Int, noticeID: Int)
    func postNoticeRemove(studyID: Int, noticeID: Int)
}

protocol NoticeDetailRemoteDataManagerOutputProtocol: class {
    func getNoticeDetailResult(result: BaseResponse<Notice>)
    func removeNoticeDetailResult(result: BaseResponse<String>)
    func sessionTaskError(message: String)
}

protocol NoticeDetailWireFrameProtocol: class {
    static func createNoticeDetailModule(notice: Int,
                                         studyID: Int?,
                                         title: String,
                                         parentView: UIViewController?,
                                         state: StudyDetailViewState) -> UIViewController
    func goToNoticeEdit(state: AddNoticeState, notice: Notice, parentView: NoticeDetailViewProtocol)
}
