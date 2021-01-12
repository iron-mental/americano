//
//  LocationModifyRemoteManager.swift
//  Terminal-iOS
//
//  Created by once on 2021/01/12.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation
import SwiftyJSON
import SwiftKeychainWrapper

class LocationModifyRemoteDataManager: LocationModifyRemoteDataManagerInputProtocol {
    var remoteRequestHandler: LocationModifyRemoteDataManagerOutputProtocol?

    func retrieveAddress() {
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
                    self.remoteRequestHandler?.onRetrieveAddress(result: result)
                case .failure(let error):
                    print(error)
                }
            }
    }
}
