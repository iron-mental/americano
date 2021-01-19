//
//  UserWithdrawalProtocols.swift
//  Terminal-iOS
//
//  Created by once on 2021/01/19.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

protocol UserWithdrawalViewProtocol: class {
    var presenter: UserWithdrawalPresenterProtocol? { get set }
}

protocol UserWithdrawalPresenterProtocol: class {
    var view: UserWithdrawalViewProtocol? { get set }
    var interactor: UserWithdrawalInteractorInputProtocol? { get set }
    var wireframe: UserWithdrawalWireFrameProtocol? { get set }
    
}


protocol UserWithdrawalInteractorInputProtocol: class {
    var presenter: UserWithdrawalInteractorOutputProtocol? { get set }
    
}

protocol UserWithdrawalInteractorOutputProtocol: class {
    
}

protocol UserWithdrawalWireFrameProtocol: class {
    static func createModule() -> UIViewController
}
