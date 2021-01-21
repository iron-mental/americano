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
}

protocol DelegateHostPresenterProtocol {
    var view: DelegateHostViewProtocol? { get set }
    var interactor: DelegateHostInteractorInputProtocol? { get set }
    var wireFrame: DelegateHostWireFrameProtocol? { get set }
}

protocol DelegateHostInteractorInputProtocol {
    var presenter: DelegateHostInteractorOutputProtocol? { get set }
    var remoteDataManager: DelegateHostPresenterProtocol? { get set }
}

protocol DelegateHostInteractorOutputProtocol {
}

protocol DelegateHostRemoteDataManagerInputProtocol {
    var interactor: DelegateHostInteractorOutputProtocol? { get set }
}

protocol DelegateHostRemoteDataManagerOutputProtocol {
    
}

protocol DelegateHostWireFrameProtocol {
    static func createDelegateHostmodule(studyID: Int) -> UIViewController
}
