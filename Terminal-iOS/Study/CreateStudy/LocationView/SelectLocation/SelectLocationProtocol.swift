//
//  selectLocationProtocol.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/27.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import NMapsMap

protocol SelectLocationViewProtocols: class {
    var presenter: SelectLocationPresenterProtocols? { get set }
    //PRESENTER -> VIEW
    func setViewWithResult(latLng: NMGLatLng, address: String)
}

protocol SelectLocationInteractorProtocols: class {
    var presenter: SelectLocationPresenterProtocols? { get set }
    var remoteDataManager: SelectLocationRemoteDataManagerProtocols? { get set }
    var localDataManager: SelectLocationLocalDataManagerProtocols? { get set }
    
    //PRESENTER -> INTERACTOR
    func searchAddress(lat: Double?, Lng: Double?)
}

protocol SelectLocationPresenterProtocols: class {
    var view: SelectLocationViewProtocols? { get set }
    var interactor: SelectLocationInteractorProtocols? { get set }
    var wireFrame: SelectLocationWireFrameProtocols? { get set }
    
    //VIEW -> PRESENTER
    func getAddress(lat: Double?, Lng: Double?)
    
    //INTERACTOR -> PRESENTER
    func getAddressResult(latLng: NMGLatLng, address: String)
}

protocol SelectLocationRemoteDataManagerProtocols: class {
    //INTERACTOR -> REMOTEDATAMANAGER
    func getAddressWithLatLng(latLng: NMGLatLng?) -> (NMGLatLng, String)
}

protocol SelectLocationLocalDataManagerProtocols: class {
    //INTERACTOR -> LOCALDATAMANAGER
    func getCurrentLocation() ->(NMGLatLng)
}

protocol SelectLocationWireFrameProtocols: class {
    var presenter: SelectLocationPresenterProtocols? { get set }
    
    static func selectLocationViewModul(item: searchLocationResult) -> UIViewController
}
