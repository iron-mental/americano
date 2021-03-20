//
//  CareerModifyProtocols.swift
//  Terminal-iOS
//
//  Created by once on 2020/12/22.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

protocol CareerModifyViewProtocol: class {
    var presenter: CareerModifyPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func modifyResultHandle(result: Bool, message: String)
    func showError(message: String, label: String)
    func showLoading()
    func hideLoading()
    func showError(message: String)
}

protocol CareerModifyWireFrameProtocol: class {
    static func createModule(title: String, contents: String) -> UIViewController
}

protocol CareerModifyPresenterProtocol: class {
    var view: CareerModifyViewProtocol? { get set }
    var interactor: CareerModifyInteractorInputProtocol? { get set }
    var wireFrame: CareerModifyWireFrameProtocol? { get set }
    
    // VIEW -> PRESENTER
    func completeModify(title: String, contents: String)
}

protocol CareerModifyInteractorInputProtocol: class {
    var presenter: CareerModifyInteractorOutputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func completeModify(title: String, contents: String)
}

protocol CareerModifyInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    func didCompleteModify(result: Bool, message: String)
    func sessionTaskError(message: String)
    func modifyFailed(message: String, label: String)
}
