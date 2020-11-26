//
//  SelectLocationInteractor.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/27.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class SelectLocationInteractor: SelectLocationInteractorProtocol {
    func selectLocation(item: StudyDetailLocationPost) {
        print("test")
    }
    
    var presenter: SelectLocationPresenterProtocol?
    var remoteDataManager: SelectLocationRemoteDataManagerProtocol?
    var localDataManager: SelectLocationLocalDataManagerProtocol?
    
    func searchAddress(item: StudyDetailLocationPost) {
        let lat = item.lat
        let lng = item.lng
        remoteDataManager?.getAddressInfo(lat: lat, lng: lng, completion: { [self] (result, data) in
            if result {
                if let item = data {
                    presenter?.getAddressResult(item: item)
                }
            } else {
                print("통신 실패요")
            }
        })
    }
}
