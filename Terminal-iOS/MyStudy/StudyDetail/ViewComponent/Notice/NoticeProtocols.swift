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
    var notice: UITableView { get set }
    
    func showNoticeList(noticeList: NoticeList)
    func showMessage(message: String)
    func noticeReloadData()
}

protocol NoticeInteractorProtocol {
    var presenter: NoticePresenterProtocol? { get set }
    var remoteDataManager: NoticeRemoteDataManagerProtocol? { get set }
    var localDataManager: NoticeLocalDataManagerProtocol? { get set }
    
    //PRESENTER -> INTERACTOR
    func getNoticeList(studyID: Int)
    func getNoticeDetail(notice: Notice, parentView: UIViewController)
}

protocol NoticePresenterProtocol {
    var view: NoticeViewProtocol? { get set }
    var wireFrame: NoticeWireFrameProtocol? { get set }
    var interactor: NoticeInteractorProtocol? { get set }
    
    //VIEW -> PRESENTER
    func viewDidLoad(studyID: Int)
    func celldidTap(notice: Notice, parentView: UIViewController)
    //INTERACTOR -> PRESENTER
    func showResult(result: Bool, noticeList: NoticeList?, message: String?)
    func noticeDetailResult(result: Bool, notice: Notice, parentView: UIViewController)
}

protocol NoticeRemoteDataManagerProtocol {

    func getNoticeList(studyID: Int, completion: @escaping (_: Bool , _: NoticeList?, _: String?) -> Void)
    func getNoticeDetail(studyID: Int, noticeID: Int, completion: @escaping (_: Bool, _: Notice) -> Void)
}

protocol NoticeLocalDataManagerProtocol {
    
}

protocol NoticeWireFrameProtocol {
    var presenter: NoticePresenterProtocol? { get set }
    
    static func createNoticeModule(studyID: Int) -> UIViewController
    func goToNoticeDetail(notice: Notice, parentView: UIViewController)
}
