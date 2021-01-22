//
//  DelegateHostProtocols.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/21.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

protocol DelegateHostViewProtocol {
    var presenter: DelegateHostPresenterProtocol? { get set }
    var userList: [Participate]? { get set }
    
    //PRESENTER -> VIEW
    func showDelegateHostResult(message: String)
    func showError()
}

protocol DelegateHostPresenterProtocol {
    var view: DelegateHostViewProtocol? { get set }
    var interactor: DelegateHostInteractorInputProtocol? { get set }
    var wireFrame: DelegateHostWireFrameProtocol? { get set }
    
    //VIEW -> PRESENTER
    func delegateHostButtonDidTap(newLeader: Int)
}

protocol DelegateHostInteractorInputProtocol {
    var presenter: DelegateHostInteractorOutputProtocol? { get set }
    var remoteDataManager: DelegateHostRemoteDataManagerInputProtocol? { get set }
    var studyID: Int? { get set }
    
    //PRESENTER -> INTERACTOR
    func putDelegateHostAPI(newLeader: Int)
}

protocol DelegateHostInteractorOutputProtocol {
    //INTERACTOR -> PRESENTER
    func delegateHostResult(result: Bool, message: String)
}

protocol DelegateHostRemoteDataManagerInputProtocol {
    var interactor: DelegateHostInteractorOutputProtocol? { get set }
    
    //INTERACTOR -> REMOTEDATAMANAGER
    func putDelegateHostAPI(studyID: Int, newLeader: Int)
}

protocol DelegateHostRemoteDataManagerOutputProtocol {
    //REMOTEDATAMANAGER -> INTERACTOR
    func delegateHostResult(response: BaseResponse<String>)
}

protocol DelegateHostWireFrameProtocol {
    static func createDelegateHostmodule(studyID: Int, userList: [Participate]) -> UIViewController
}
