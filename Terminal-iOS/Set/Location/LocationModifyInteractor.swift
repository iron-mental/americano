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
    
    func address() {
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.address)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let data = "\(json)".data(using: .utf8)
                    let result = try! JSONDecoder().decode(BaseResponse<[Address]>.self, from: data!)
                    let isSuccess = result.result
                    let addressList = result.data!
                    self.presenter?.retrievedAddress(result: isSuccess, address: addressList)
                case .failure(let error):
                    print(error)
                }
            }
    }
}
