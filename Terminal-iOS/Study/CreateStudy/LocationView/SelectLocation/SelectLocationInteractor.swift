//
//  SelectLocationInteractor.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/27.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class SelectLocationInteractor: SelectLocationInteractorProtocols {
    var presenter: SelectLocationPresenterProtocols?
    var remoteDataManager: SelectLocationRemoteDataManagerProtocols?
    var localDataManager: SelectLocationLocalDataManagerProtocols?
    
    func searchAddress(lat: Double?, Lng: Double?) {
        print("searchAddress")
    }
    

}
