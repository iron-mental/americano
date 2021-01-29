//
//  LocationModifyRemoteManager.swift
//  Terminal-iOS
//
//  Created by once on 2021/01/12.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftKeychainWrapper

class LocationModifyRemoteDataManager: LocationModifyRemoteDataManagerInputProtocol {
    var remoteRequestHandler: LocationModifyRemoteDataManagerOutputProtocol?

    func retrieveAddress() {
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.address)
            .validate(statusCode: 200...422)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let data = "\(json)".data(using: .utf8)
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<[Address]>.self, from: data!)
                        self.remoteRequestHandler?.onRetrieveAddress(result: result)
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
    func retrieveCoordinates(location: String, completion: @escaping (_ x: Double, _ y: Double) -> Void) {
        let url = API.KAKAO_BASE_URL
        let headers: HTTPHeaders = [
            "Authorization": "KakaoAK ec74a28d28177a706155cb8af1fb7ec8"
        ]
        let parameters: [String: String] = [
            "query": location
        ]
        
        AF.request(url,
                   method: .get,
                   parameters: parameters,
                   headers: headers)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)["documents"][0]
                    let latitude = json["x"].doubleValue
                    let longitude = json["y"].doubleValue

                    completion(latitude, longitude)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func completeModify(params: [String: Any]) {
        guard let userID = KeychainWrapper.standard.string(forKey: "userID") else { return }
        
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.userLocationUpdate(id: userID, location: params))
            .validate(statusCode: 200...422)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let data = "\(json)".data(using: .utf8)
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<Bool>.self, from: data!)
                        self.remoteRequestHandler?.didCompleteModify(result: result)
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}
