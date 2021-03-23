//
//  ApplyUserDetailProtocols.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/14.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

protocol ApplyUserDetailViewProtocol: BaseProfileViewProtocol {
    var presenter: ApplyUserDetailPresenterInputProtocol? { get set }
    
    // PRESENTER -> View
    func showUserInfo(userInfo: ApplyUserInfo)
    func showError(message: String)
    func showApplyStatusResult(message: String, studyID: Int)
}

protocol ApplyUserDetailPresenterInputProtocol: class {
    var view: ApplyUserDetailViewProtocol? { get set }
    var interactor: ApplyUserDetailInteractorInputProtocol? { get set }
    var wireFrame: ApplyUserDetailWireFrameProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    func rejectButtonDidTap()
    func acceptButtonDidtap()
}

protocol ApplyUserDetailInteractorInputProtocol: class {
    var presenter: ApplyUserDetailInteractorOutputProtocol? { get set }
    var remoteDataManager: ApplyUserDetailRemoteDataManagerInputProtocol? { get set }
    var studyID: Int? { get set }
    var applyID: Int? { get set }
    var userID: Int? { get set }
    
    // PRESENTER -> INTERACTOR
    func getUserInfo()
    func postRejectStatus()
    func postAcceptStatus()
}

protocol ApplyUserDetailInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    func retriveUserInfo(result: Bool, userInfo: ApplyUserInfo)
    func retriveApplyStatus(result: Bool, message: String, studyID: Int)
    func sessionTaskError(message: String)
}

protocol ApplyUserDetailRemoteDataManagerInputProtocol: class {
    var interactor: ApplyUserDetailRemoteDataManagerOutputProtocol? { get set }
    
    // INTERACTOR -> REMOTEDATAMANAGER
    func postApplyStatus(studyID: Int, applyID: Int, status: Bool)
    func getApplyUserInfo(studyID: Int, applyID: Int)
}

protocol ApplyUserDetailRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
    func onUserInfoRetrieved(userInfo: BaseResponse<ApplyUserInfo>)
    func onApplyStatusRetrieved(response: BaseResponse<String>)
    func sessionTaskError(message: String)
}

protocol ApplyUserDetailWireFrameProtocol: class {
    static func createApplyUserDetailModule(userInfo: ApplyUser, studyID: Int) -> UIViewController
}
