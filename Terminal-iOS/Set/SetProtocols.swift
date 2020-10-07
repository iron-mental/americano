//
//  SetViewProtocols.swift
//  Terminal-iOS
//
//  Created by once on 2020/09/30.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

protocol SetViewProtocol: class {
    var presenter: SetPresenterProtocol? { get set }
}

protocol SetWireFrameProtocol: class {
    static func createModule() -> UIViewController
    
    // PRESENT -> WIREFRAME
    func presentMenuDetailScreen(from view: SetViewProtocol)
}

protocol SetPresenterProtocol: class {
    var view: SetViewProtocol? { get set }
    var interactor: SetInteractortInputProtocol? { get set }
    var wireFrame: SetWireFrameProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    
}

protocol SetInteractorOutputProtocol: class {
    
}

protocol SetInteractortInputProtocol: class {
    
}

protocol SetDataManagerInputProtocol: class {
    
}

protocol SetRemoteDataManagerInputProtocol: class {
    
}

protocol SetRemoteDataManagerOutputProtocol: class {
    
}

protocol SetLocalDataManagerInputProtocol: class {

}
