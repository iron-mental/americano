//
//  AddNoticeProtocols.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/27.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

protocol AddNoticeViewProtocol: class {
    var presenter: AddNoticePresenterProtocol? { get set }
    var studyID: Int? { get set }
    var notice: Notice? { get set }
    var state: AddNoticeState? { get set }
    var parentView: UIViewController? { get set }
    
    func showNewNotice(noticeID: Int)
}

protocol AddNoticeInteractorProtocol: class {
    var presenter: AddNoticePresenterProtocol? { get set }
    var remoteDataManager: AddNoticeRemoteDataManagerProtocol? { get set }
    var localDataManager: AddNoticeLocalDataManagerProtocol? { get set }
    //PRESENTER -> INTERACTOR
    func postNotice(studyID: Int, notice: NoticePost, state: AddNoticeState, noticeID: Int?)
}

protocol AddNoticePresenterProtocol: class {
    var view: AddNoticeViewProtocol? { get set }
    var wireFrame: AddNoticeWireFrameProtocol? { get set }
    var interactor: AddNoticeInteractorProtocol? { get set }
    
    //VIEW -> PRESENTER
    func completeButtonDidTap(studyID: Int, notice: NoticePost, state: AddNoticeState, noticeID: Int?)
    
    //INTERACTOR -> PRESENTER
    func addNoticeResult(result: Bool, notice: Int, studyID: Int)
}

protocol AddNoticeRemoteDataManagerProtocol: class {
    //INTERACTOR -> REMOTE
    func postNotice(studyID: Int, notice:  NoticePost, completion: @escaping (_ result: Bool, _ noticeID : Int) -> Void)
    func putNotice(studyID: Int, notice: NoticePost, noticeID: Int, completion: @escaping(_ result: Bool, _ noticeID: Int) -> Void)
}

protocol AddNoticeLocalDataManagerProtocol: class {
    
}

protocol AddNoticeWireFrameProtocol: class {
    var presenter: AddNoticePresenterProtocol? { get set }
    
    static func createAddNoticeModule(studyID: Int?, notice: Notice?, parentView: UIViewController, state: AddNoticeState) -> UIViewController
    func goToNoticeDetailView(noticeID: Int, studyID: Int, parentView: UIViewController?)
}
