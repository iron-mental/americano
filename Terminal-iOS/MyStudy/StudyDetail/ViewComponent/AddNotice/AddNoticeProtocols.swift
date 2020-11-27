//
//  AddNoticeProtocols.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/27.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

protocol AddNoticeViewProtocol {
    var presenter: AddNoticePresenterProtocol? { get set }
    var studyID: Int? { get set }
    
    func showNewNotice()
}

protocol AddNoticeInteractorProtocol {
    var presenter: AddNoticePresenterProtocol? { get set }
    var remoteDataManager: AddNoticeRemoteDataManagerProtocol? { get set }
    var localDataManager: AddNoticeLocalDataManagerProtocol? { get set }
    //PRESENTER -> INTERACTOR
    func postNotice(studyID: Int, notice: NoticePost)
}

protocol AddNoticePresenterProtocol {
    var view: AddNoticeViewProtocol? { get set }
    var wireFrame: AddNoticeWireFrameProtocol? { get set }
    var interactor: AddNoticeInteractorProtocol? { get set }
    
    //VIEW -> PRESENTER
    func completeButtonDidTap(studyID: Int, notice: NoticePost)
    
    //INTERACTOR -> PRESENTER
    func addNoticeResult(result: Bool, notice: String)
}

protocol AddNoticeRemoteDataManagerProtocol {
    //INTERACTOR -> REMOTE
    func postNotice(studyID: Int, notice:  NoticePost, completion: @escaping (_: Bool, _: String) -> Void)
}

protocol AddNoticeLocalDataManagerProtocol {
    
}

protocol AddNoticeWireFrameProtocol {
    var presenter: AddNoticePresenterProtocol? { get set }
    
    static func createAddNoticeModule(studyID: Int) -> UIViewController
}
