//
//  LocationModifyInteractor.swift
//  Terminal-iOS
//
//  Created by once on 2020/12/22.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation
import SwiftyJSON

class LocationModifyInteractor: LocationModifyInteractorInputProtocol {
    var presenter: LocationModifyInteractorOutputProtocol?
    var remoteDataManager: LocationModifyRemoteDataManagerInputProtocol?
    
    func retrieveAddress() {
        remoteDataManager?.retrieveAddress()
    }
    
    func retrieveCoordinates(sido: String, sigungu: String) {
        let location = sido + " " + sigungu
        
        remoteDataManager?.retrieveCoordinates(location: location) { x, y in
            let params: [String: Any] = [
                "latitude": y,
                "longitude": x,
                "sido": sido,
                "sigungu": sigungu
            ]
            
            self.remoteDataManager?.completeModify(params: params)
        }
    }
}

extension LocationModifyInteractor: LocationModifyRemoteDataManagerOutputProtocol {
    func onRetrieveAddress(result: BaseResponse<[Address]>) {
        let isSuccess: Bool = result.result
        let address: [Address] = result.data!  // 일단 강제 언래핑
        self.presenter?.retrievedAddress(result: isSuccess, address: address)
    }
    
    func didCompleteModify(result: BaseResponse<Bool>) {
        if result.result {
            self.presenter?.didCompleteModify(result: result.result,
                                              message: result.message!)
        }
    }
}
