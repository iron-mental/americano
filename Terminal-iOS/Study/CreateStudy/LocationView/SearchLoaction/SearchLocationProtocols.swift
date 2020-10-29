//
//  SearchLocationProtocols.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/10/29.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

protocol SearchLocationViewProtocol: class {
    var presenter: SearchLocationPresenterProtocol? { get set }
}

protocol SearchLocationPresenterProtocol: class {
    var view: SearchLocationViewProtocol? { get set }
    var interactor: SearchLocationInteractorProtocol? { get set }
    var wireFrame: SearchLocationWireFrameProtocol? { get set }
}

protocol SearchLocationInteractorProtocol: class {
    var remoteDataManager: SearchLocationRemoteDataManagerProtocol? { get set }
}

protocol SearchLocationRemoteDataManagerProtocol: class {
    
}

protocol SearchLocationWireFrameProtocol: class {
    var presenter : SearchLocationPresenterProtocol? { get set }
}

