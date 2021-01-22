//
//  NoticeProtocols.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/25.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

protocol NoticeViewProtocol {
    var studyID: Int? { get set }
    var presenter: NoticePresenterProtocol? { get set }
    var noticeList: [Notice] { get set }
    
    func showNoticeList(noticeList: [Notice])
    func showMessage(message: String)
    func viewLoad()
    func showLoading()
}

protocol NoticeInteractorProtocol {
    var presenter: NoticePresenterProtocol? { get set }
    var remoteDataManager: NoticeRemoteDataManagerProtocol? { get set }
    var localDataManager: NoticeLocalDataManagerProtocol? { get set }

    //PRESENTER -> INTERACTOR
    func getNoticeList(studyID: Int)
//    func getNoticeDetail(notice: Notice, parentView: UIViewController)
    func getNoticeListPagination(studyID: Int)
}

protocol NoticePresenterProtocol {
    var view: NoticeViewProtocol? { get set }
    var wireFrame: NoticeWireFrameProtocol? { get set }
    var interactor: NoticeInteractorProtocol? { get set }
    
    //VIEW -> PRESENTER
    func viewDidLoad(studyID: Int)
    func celldidTap(notice: Notice, parentView: UIViewController, state: StudyDetailViewState)
    func didScrollEnded(studyID: Int)
    
    //INTERACTOR -> PRESENTER
    func showResult(result: Bool, noticeList: [Notice]?, message: String?)
//    func noticeDetailResult(result: Bool, notice: Notice, parentView: UIViewController)
    func showNoticePaginationResult(result: Bool, notice: [Notice]?, message: String?)
}

protocol NoticeRemoteDataManagerProtocol {
    func getNoticeList(studyID: Int, completion: @escaping ( _ result: Bool, _ data: [Notice]?, _ message: String?) -> Void)
//    func getNoticeDetail(studyID: Int, noticeID: Int, completion: @escaping ( _ result: Bool, _ data: Notice) -> Void)
    func getNoticeListPagination(studyID: Int, noticeListIDs: [Int], completion: @escaping ( _ result: Bool, _ data: [Notice]?, _ message: String?) -> Void)
}

protocol NoticeLocalDataManagerProtocol {
    
}

protocol NoticeWireFrameProtocol {
    var presenter: NoticePresenterProtocol? { get set }
    
    static func createNoticeModule(studyID: Int) -> UIViewController
    func goToNoticeDetail(notice: Notice, parentView: UIViewController, state: StudyDetailViewState)
}
