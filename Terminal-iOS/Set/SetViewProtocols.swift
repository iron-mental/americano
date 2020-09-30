//
//  SetViewProtocols.swift
//  Terminal-iOS
//
//  Created by once on 2020/09/30.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

protocol SetViewProtocol: class {
    var presenter: SetViewPresenterProtocol? { get set }
}

protocol SetViewWireFrameProtocol: class {
    static func createModule() -> UIViewController
    
    // PRESENT -> WIREFRAME
    func presentMenuDetailScreen(from view: SetViewProtocol)
}

protocol SetViewPresenterProtocol: class {
    var view: SetViewProtocol? { get set }
    var interactor: SetViewInteractortInputProtocol? { get set }
    var wireFrame: SetViewWireFrameProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    
}

protocol SetViewInteractorOutputProtocol: class {
    
}

protocol SetViewInteractortInputProtocol: class {
    
}

protocol SetViewDataManagerInputProtocol: class {
    
}

protocol SetViewRemoteDataManagerInputProtocol: class {
    
}

protocol SetViewRemoteDataManagerOutputProtocol: class {
    
}

protocol SetViewLocalDataManagerInputProtocol: class {

}
