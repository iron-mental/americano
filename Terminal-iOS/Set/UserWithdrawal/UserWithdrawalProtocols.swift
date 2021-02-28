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
    
    func resultUserWithdrawal(message: String?)
    func hideLoading()
    func showLoading()
}

protocol UserWithdrawalPresenterProtocol: class {
    var view: UserWithdrawalViewProtocol? { get set }
    var interactor: UserWithdrawalInteractorInputProtocol? { get set }
    var wireframe: UserWithdrawalWireFrameProtocol? { get set }
    
    func userWithdrawal(email: String, password: String)
    func goToIntroView()
}

protocol UserWithdrawalInteractorInputProtocol: class {
    var presenter: UserWithdrawalInteractorOutputProtocol? { get set }
    
    func userWithdrawal(email: String, password: String)
}

protocol UserWithdrawalInteractorOutputProtocol: class {
    func resultUserWithdrawal(result: Bool, message: String)
}

protocol UserWithdrawalWireFrameProtocol: class {
    static func createModule() -> UIViewController
    
    func goToIntroView(from view: UserWithdrawalViewProtocol)
}
