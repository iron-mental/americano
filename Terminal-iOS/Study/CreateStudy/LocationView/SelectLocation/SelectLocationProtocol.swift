//
//  selectLocationProtocol.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/27.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import NMapsMap

protocol SelectLocationViewProtocol: class {
    var presenter: SelectLocationPresenterProtocol? { get set }
    //PRESENTER -> VIEW
    func setViewWithResult(item: searchLocationResult)
}

protocol SelectLocationInteractorProtocol: class {
    var presenter: SelectLocationPresenterProtocol? { get set }
    var remoteDataManager: SelectLocationRemoteDataManagerProtocol? { get set }
    var localDataManager: SelectLocationLocalDataManagerProtocol? { get set }
    
    //PRESENTER -> INTERACTOR
    func searchAddress(item: searchLocationResult)
    func selectLocation(item: searchLocationResult)
}

protocol SelectLocationPresenterProtocol: class {
    var view: SelectLocationViewProtocol? { get set }
    var interactor: SelectLocationInteractorProtocol? { get set }
    var wireFrame: SelectLocationWireFrameProtocol? { get set }
    
    //VIEW -> PRESENTER
    func getAddress(item: searchLocationResult)
    func didClickedCompletButton(item: searchLocationResult)
    
    //INTERACTOR -> PRESENTER
    func getAddressResult(item: searchLocationResult)
}

protocol SelectLocationRemoteDataManagerProtocol: class {
    //INTERACTOR -> REMOTEDATAMANAGER
    func getAddressInfo(lat: Double, lng: Double, completion: @escaping (_: Bool, _ item: searchLocationResult?) -> ())
}

protocol SelectLocationLocalDataManagerProtocol: class {
    //INTERACTOR -> LOCALDATAMANAGER
}

protocol SelectLocationWireFrameProtocol: class {
    var presenter: SelectLocationPresenterProtocol? { get set }
    
    static func selectLocationViewModul(item: searchLocationResult) -> UIViewController
}
