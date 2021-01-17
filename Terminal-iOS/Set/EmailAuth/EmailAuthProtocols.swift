//
//  EmailAuthProtocols.swift
//  Terminal-iOS
//
//  Created by once on 2021/01/17.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

protocol EmailAuthViewProtocol: class {
    var presenter: EmailAuthPresenterProtocol? { get set }
    
    func emailAuthResponse(result: Bool, message: String)
}

protocol EmailAuthPresenterProtocol: class {
    var view: EmailAuthViewProtocol? { get set }
    var wireframe: EmailAuthWireFrameProtocol? { get set }
    var interactor : EmailAuthInteractorInputProtocol? { get set }
    
    // VIEW -> PRESENTER
    func emailAuthRequest()
}

protocol EmailAuthInteractorInputProtocol: class {
    var presenter: EmailAuthInteractorOutputProtocol? { get set }
    
    func emailAuthRequest()
}

protocol EmailAuthInteractorOutputProtocol: class {
    func eamilAuthResponse(result: Bool, message: String)
}

protocol EmailAuthWireFrameProtocol: class {
    static func createModule() -> UIViewController
}
