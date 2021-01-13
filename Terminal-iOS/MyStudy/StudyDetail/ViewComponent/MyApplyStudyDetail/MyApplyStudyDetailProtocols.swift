//
//  MyApplyStudyDetailProtocols.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/11.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit


protocol MyApplyStudyDetailViewProtocol {
    var presenter: MyApplyStudyDetailPresenterInputProtocol? { get set }
    var studyID: Int? { get set }
    
//    PRESENTER -> VIEW
    func showMyApplyStudyDetail(message: String)
    func showModifyApplyMessageResult(message: String)
    func showError()
}

protocol MyApplyStudyDetailPresenterInputProtocol {
    var view: MyApplyStudyDetailViewProtocol? { get set }
    var interactor: MyApplyStudyDetailInteractorInputProtocol? { get set }
    var wireFrame: MyApplyStudyDetailWireFrameProtocol? { get set }
    
//    VIEW -> PRESENTER
    func viewDidLoad(studyID: Int)
    func admitButtonDidTap(newMessage: String)
}

protocol MyApplyStudyDetailInteractorInputProtocol {
    var presenter: MyApplyStudyDetailInteractorOutputProtocol? { get set }
    var remoteDataManager: MyApplyStudyDetailRemoteDataManagerInputProtocol? { get set }
    
//    PRESENTER -> INTERACTOR
    func getMyApplyStudyDetail(studyID: Int)
    func putNewApplyMessage(newMessage: String)
}

protocol MyApplyStudyDetailInteractorOutputProtocol {
    
//    INTERACTOR -> PRESENTER
    func retriveMyApplyStudyDetail(result: Bool, message: String)
    func retriveModifyApplyMessage(result: Bool, message: String)
}

protocol MyApplyStudyDetailRemoteDataManagerInputProtocol {
    var interactor: MyApplyStudyDetailRemoteDataManagerOutputProtocol? { get set }
    
//    INTERACTOR -> REMOTEDATAMANAGER
    func getMyApplyStudyDetail(studyID: Int, userID: Int)
    func putNewApplyMessage(studyID: Int,applyID: Int, newMessage: String)
}

protocol MyApplyStudyDetailRemoteDataManagerOutputProtocol {
    
//    REMOTEDATAMANAGER -> INTERACTOR
    func retriveMyApplyStudyDetail(result: Bool, data: ApplyUserResult)
    func retriveModifyApplyMessage(result: Bool, message: String)
}

protocol MyApplyStudyDetailWireFrameProtocol {
    static func createMyApplyStudyDetailModule(studyID: Int) -> UIViewController
}
