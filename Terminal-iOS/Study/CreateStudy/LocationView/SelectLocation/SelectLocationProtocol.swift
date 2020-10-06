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
    var presenter: SelectLocationPresenterProtocol { get set }
    
    //PRESENTER -> VIEW
    func setViewWithResult(latLng: NMGLatLng, address: String)
}

protocol SelectLocationInteractorProtocol: class {
    var presenter: SelectLocationPresenterProtocol { get set }
    var remoteDataManager: SelectLocationRemoteDataManagerProtocol { get set }
    var localDataManager: SelectLocationLocalDataManagerProtocol { get set }
    
    //PRESENTER -> INTERACTOR
    func searchAddress(lat: Double?, Lng: Double?)
}

protocol SelectLocationPresenterProtocol: class {
    var view: SelectLocationViewProtocol { get set }
    var interactor: SelectLocationInteractorProtocol { get set }
    var wireFrame: SelectLocationWireFrameProtocol { get set }
    
    //VIEW -> PRESENTER
    func getAddress(lat: Double?, Lng: Double?)
    
    //INTERACTOR -> PRESENTER
    func getAddressResult(latLng: NMGLatLng, address: String)
}

protocol SelectLocationRemoteDataManagerProtocol: class {
    //INTERACTOR -> REMOTEDATAMANAGER
    func getAddressWithLatLng(latLng: NMGLatLng?) -> (NMGLatLng, String)
}

protocol SelectLocationLocalDataManagerProtocol: class {
    //INTERACTOR -> LOCALDATAMANAGER
    func getCurrentLocation() ->(NMGLatLng)
}

protocol SelectLocationWireFrameProtocol: class {
    var presenter: SelectLocationPresenterProtocol { get set }
}
