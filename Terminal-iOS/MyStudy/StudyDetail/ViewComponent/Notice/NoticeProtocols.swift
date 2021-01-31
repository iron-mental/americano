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
    
    //PRESENTER -> VIEW
    func showNoticeList(firstNoticeList: [Notice], secondNoticeList: [Notice])
    func showMessage(message: String)
    func viewLoad()
    func showLoading()
}

protocol NoticeInteractorInputProtocol {
    var presenter: NoticeInteractorOutputProtocol? { get set }
    var remoteDataManager: NoticeRemoteDataManagerProtocol? { get set }

    //PRESENTER -> INTERACTOR
    func getNoticeList(studyID: Int)
    func getNoticeListPagination(studyID: Int)
}

protocol NoticeInteractorOutputProtocol {
    
    //INTERACTOR -> PRESENTER
    func showResult(result: Bool, firstNoticeList: [Notice], secondNoticeList: [Notice], message: String?)
    func showNoticePaginationResult(result: Bool, firstNoticeList: [Notice], secondNoticeList: [Notice], message: String?)
    func showError(message: String)
}

protocol NoticePresenterProtocol {
    var view: NoticeViewProtocol? { get set }
    var wireFrame: NoticeWireFrameProtocol? { get set }
    var interactor: NoticeInteractorInputProtocol? { get set }
    
    //VIEW -> PRESENTER
    func viewDidLoad(studyID: Int)
    func celldidTap(notice: Notice, parentView: UIViewController, state: StudyDetailViewState)
    func didScrollEnded(studyID: Int)
}

protocol NoticeRemoteDataManagerProtocol {
    func getNoticeList(studyID: Int, completion: @escaping ( _ result: Bool, _ data: [Notice]?, _ message: String?) -> Void)
    func getNoticeListPagination(studyID: Int, noticeListIDs: [Int], completion: @escaping ( _ result: Bool, _ data: [Notice]?, _ message: String?) -> Void)
}

protocol NoticeWireFrameProtocol {
    var presenter: NoticePresenterProtocol? { get set }
    
    static func createNoticeModule(studyID: Int) -> UIViewController
    func goToNoticeDetail(notice: Notice, parentView: UIViewController, state: StudyDetailViewState)
}
