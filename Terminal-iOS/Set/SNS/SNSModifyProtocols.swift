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
}

protocol SNSModifyWireFrameProtocol: class {
    static func createModule() -> UIViewController
    
    func presentProfileModifyScreen(from view: SNSModifyViewProtocol, userInfo: UserInfo, project: [Project])
}

protocol SNSModifyPresenterProtocol: class {
    var view: SNSModifyViewProtocol? { get set }
    var interactor: SNSModifyInteractorInputProtocol? { get set }
    var wireFrame: SNSModifyWireFrameProtocol? { get set }
    
    // VIEW -> PRESENTER
}

protocol SNSModifyInteractorInputProtocol: class {
    var presenter: SNSModifyInteractorOutputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
   
}

protocol SNSModifyInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    
}
