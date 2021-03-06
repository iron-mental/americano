//
//  DelegateHostProtocols.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/21.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

protocol DelegateHostViewProtocol: class {
    var presenter: DelegateHostPresenterProtocol? { get set }
    var userList: [Participate]? { get set }
    var studyID: Int? { get set }
    
    //PRESENTER -> VIEW
    func showDelegateHostResult(message: String)
    func showError(message: String)
}

protocol DelegateHostPresenterProtocol: class {
    var view: DelegateHostViewProtocol? { get set }
    var interactor: DelegateHostInteractorInputProtocol? { get set }
    var wireFrame: DelegateHostWireFrameProtocol? { get set }
    
    //VIEW -> PRESENTER
    func delegateHostButtonDidTap(newLeader: Int)
}

protocol DelegateHostInteractorInputProtocol: class {
    var presenter: DelegateHostInteractorOutputProtocol? { get set }
    var remoteDataManager: DelegateHostRemoteDataManagerInputProtocol? { get set }
    var studyID: Int? { get set }
    
    //PRESENTER -> INTERACTOR
    func putDelegateHostAPI(newLeader: Int)
}

protocol DelegateHostInteractorOutputProtocol: class {
    //INTERACTOR -> PRESENTER
    func delegateHostResult(result: Bool, message: String)
    func sessionTaskError(message: String)
}

protocol DelegateHostRemoteDataManagerInputProtocol: class {
    var interactor: DelegateHostRemoteDataManagerOutputProtocol? { get set }
    
    //INTERACTOR -> REMOTEDATAMANAGER
    func putDelegateHostAPI(studyID: Int, newLeader: Int)
}

protocol DelegateHostRemoteDataManagerOutputProtocol: class {
    //REMOTEDATAMANAGER -> INTERACTOR
    func delegateHostResult(response: BaseResponse<String>)
    func sessionTaskError(message: String)
}

protocol DelegateHostWireFrameProtocol: class {
    static func createDelegateHostmodule(studyID: Int, userList: [Participate]) -> UIViewController
}
