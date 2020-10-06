//
//  SelectLocationPresenter.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/27.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import NMapsMap

class SelectLocationPresenter: SelectLocationPresenterProtocols {
    var view: SelectLocationViewProtocols?
    var interactor: SelectLocationInteractorProtocols?
    var wireFrame: SelectLocationWireFrameProtocols?
    
    func getAddress(lat: Double?, Lng: Double?) {
        print("getAddress")
    }
    func getAddressResult(latLng: NMGLatLng, address: String) {
        print("getAddressResult")
    }
    

}
