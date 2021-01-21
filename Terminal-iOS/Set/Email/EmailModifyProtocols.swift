//
//  EmailModifyProtocols.swift
//  Terminal-iOS
//
//  Created by once on 2020/12/22.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

protocol EmailModifyViewProtocol: class {
    var presenter: EmailModifyPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
}

protocol EmailModifyWireFrameProtocol: class {
    static func createModule(email: String) -> UIViewController
    
    func presentProfileModifyScreen(from view: EmailModifyViewProtocol, userInfo: UserInfo, project: [Project])
}

protocol EmailModifyPresenterProtocol: class {
    var view: EmailModifyViewProtocol? { get set }
    var interactor: EmailModifyInteractorInputProtocol? { get set }
    var wireFrame: EmailModifyWireFrameProtocol? { get set }
    
    // VIEW -> PRESENTER
}

protocol EmailModifyInteractorInputProtocol: class {
    var presenter: EmailModifyInteractorOutputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
   
}

protocol EmailModifyInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    
}
