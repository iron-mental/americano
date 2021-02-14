//
//  ApplyUserProtocols.swift
//  Terminal-iOS
//
//  Created by once on 2020/12/11.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

protocol ApplyUserViewProtocol: class {
    var presenter: ApplyUserPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func showUserList(userList: [ApplyUser]?)
    func showError(message: String)
    func showLoading()
    func hideLoading()
}

protocol ApplyUserWireFrameProtocol: class {
    static func createUserListModule(studyID: Int) -> UIViewController
    
    // PRESENT -> WIREFRAME
    func presentUserInfoDetailScreen(from view: ApplyUserViewProtocol, userInfo: ApplyUser, studyID: Int)
}

protocol ApplyUserPresenterProtocol: class {
    var view: ApplyUserViewProtocol? { get set }
    var interactor: ApplyUserInteractorInputProtocol? { get set }
    var wireFrame: ApplyUserWireFrameProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad(studyID: Int)
    func showUserInfoDetail(userInfo: ApplyUser, studyID: Int)
}

protocol ApplyUserInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    func didRetrieveUser(userList: [ApplyUser]?)
    func onError(message: String)
}

protocol ApplyUserInteractorInputProtocol: class {
    var presenter: ApplyUserInteractorOutputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func getApplyList(studyID: Int)
}
