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
    
    func showNoticeList(noticeList: NoticeList)
    func showMessage(message: String)
}

protocol NoticeInteractorProtocol {
    var presenter: NoticePresenterProtocol? { get set }
    var remoteDataManager: NoticeRemoteDataManagerProtocol? { get set }
    var localDataManager: NoticeLocalDataManagerProtocol? { get set }
    
    //PRESENTER -> INTERACTOR
    func getNoticeList(studyID: Int)
}

protocol NoticePresenterProtocol {
    var view: NoticeViewProtocol? { get set }
    var wireFrame: NoticeWireFrameProtocol? { get set }
    var interactor: NoticeInteractorProtocol? { get set }
    
    //VIEW -> PRESENTER
    func viewDidLoad(studyID: Int)
    //INTERACTOR -> PRESENTER
    func showResult(result: Bool, noticeList: NoticeList?, message: String?)
}

protocol NoticeRemoteDataManagerProtocol {

    func getNoticeList(studyID: Int, completion: @escaping (Bool, NoticeList?, String?) -> Void)
}

protocol NoticeLocalDataManagerProtocol {
    
}

protocol NoticeWireFrameProtocol {
    var presenter: NoticePresenterProtocol? { get set }
    
    static func createNoticeModule(studyID: Int) -> UIViewController
}
