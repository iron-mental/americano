//
//  EmailModifyProtocols.swift
//  Terminal-iOS
//
//  Created by once on 2020/12/22.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

protocol SNSModifyViewProtocol: class {
    var presenter: SNSModifyPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func modifyResultHandle(result: Bool, message: String)
    func showLoading()
    func hideLoading()
    func showError(message: String)
}

protocol SNSModifyWireFrameProtocol: class {
    static func createModule(github: String, linkedin: String, web: String) -> UIViewController
    
    func presentProfileModifyScreen(from view: SNSModifyViewProtocol, userInfo: UserInfo, project: [Project])
}

protocol SNSModifyPresenterProtocol: class {
    var view: SNSModifyViewProtocol? { get set }
    var interactor: SNSModifyInteractorInputProtocol? { get set }
    var wireFrame: SNSModifyWireFrameProtocol? { get set }
    
    // VIEW -> PRESENTER
    func completeModify(github: String, linkedin: String, web: String)
}

protocol SNSModifyInteractorInputProtocol: class {
    var presenter: SNSModifyInteractorOutputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func completeModify(github: String, linkedin: String, web: String)
}

protocol SNSModifyInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    func didCompleteModify(result: Bool, message: String)
    func sessionTaskError(message: String)
}
