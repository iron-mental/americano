//
//  ParticapateProfileProtocols.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/02/24.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

protocol ParticipantProfileViewProtocol: BaseProfileViewProtocol {
    var presenter: ParticipantProfilePresenterProtocol? { get set }
    
    //PRESENTER -> View
    func showError(message: String)
    func showLoading()
    func hideLoading()
}

protocol ParticipantProfilePresenterProtocol: class {
    var view: ParticipantProfileViewProtocol? { get set }
    var interactor: ParticipantProfileInteractorInputProtocol? { get set }
    var wireFrame: ParticipantProfileWireFrameProtocol? { get set }
    
    //VIEW -> PRESENTER
    func viewDidLoad()
}

protocol ParticipantProfileInteractorInputProtocol: class {
    var presenter: ParticipantProfileInteractorOutputProtocol? { get set }
    var remoteDataManager: ParticipantProfileRemoteDataManagerInputProtocol? { get set }
    var userID: Int? { get set }
    
    //PRESENTER -> INTERACTOR
    func getUserInfo()
}

protocol ParticipantProfileInteractorOutputProtocol: class {
    //INTERACTOR -> PRESENTER
    func retriveUserInfo(result: Bool, userInfo: UserInfo)
    func retriveProjectList(result: Bool, projectList: [Project])
    func showError(message: String)
}

protocol ParticipantProfileRemoteDataManagerInputProtocol: BaseProfileRemoteDataManagerInputProtocol {
}

protocol ParticipantProfileRemoteDataManagerOutputProtocol: BaseProfileRemoteDataManagerOutputProtocol {
}

protocol ParticipantProfileWireFrameProtocol: class {
    static func createParticipantProfileModule(userInfo: Int) -> UIViewController
}
