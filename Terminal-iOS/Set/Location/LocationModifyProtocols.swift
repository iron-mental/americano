//
//  LocationModifyProtocols.swift
//  Terminal-iOS
//
//  Created by once on 2020/12/22.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

protocol LocationModifyViewProtocol: class {
    var presenter: LocationModifyPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
}

protocol LocationModifyWireFrameProtocol: class {
    static func createModule() -> UIViewController
}

protocol LocationModifyPresenterProtocol: class {
    var view: LocationModifyViewProtocol? { get set }
    var interactor: LocationModifyInteractorInputProtocol? { get set }
    var wireFrame: LocationModifyWireFrameProtocol? { get set }
    
    // VIEW -> PRESENTER
}

protocol LocationModifyInteractorInputProtocol: class {
    var presenter: LocationModifyInteractorOutputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
   
}

protocol LocationModifyInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    
}
