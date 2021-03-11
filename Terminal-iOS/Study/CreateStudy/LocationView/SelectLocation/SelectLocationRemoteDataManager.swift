//
//  SelectLocationRemoteDataManager.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/27.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import NMapsMap
import Alamofire
import SwiftyJSON

final class SelectLocationRemoteDataManager: SelectLocationRemoteDataManagerProtocol {
    weak var interactor: SelectLocationInteractorProtocol?
    
    func getAddressInfoOnce(lat: Double,
                            lng: Double,
                            completion: @escaping (Bool, _ sido: String?, _ sigungu: String?) -> Void) {
        let headers: HTTPHeaders = [ "Authorization": "KakaoAK 6cd40b04c090b1a033634e5051aab78c" ]
        let parameters: Parameters = [
            "x": lng,
            "y": lat
        ]
        
        AF.request("https://dapi.kakao.com/v2/local/geo/coord2address.json",
                   method: .get,
                   parameters: parameters,
                   headers: headers).responseJSON(completionHandler: { response in
                    
                    switch response.result {
                    case .success(let value):
                        if JSON(value)["documents"].count == 0 {
                            completion(false, nil, nil)
                        } else {
                            if let addressList = JSON(value)["documents"].array {
                                for item in addressList {
                                    let addressValid = item["road_address"]["address_name"] != JSON.null
                                    let sido = addressValid ? item["road_address"]["region_1depth_name"].string! : item["address"]["region_1depth_name"].string!
                                    let sigungu = addressValid ? item["road_address"]["region_2depth_name"].string! : item["address"]["region_2depth_name"].string!
                                    completion(true, sido, sigungu)
                                }
                            }
                        }
                    case .failure(let err) :
                        if let err = err.asAFError {
                            switch err {
                            case .sessionTaskFailed:
                                self.interactor?.sessionTaskError(message: TerminalNetworkManager.shared.sessionTaskErrorMessage)
                            default: break
                            }
                        }
                    }
                   })
    }
    
    func getAddressInfo(lat: Double, lng: Double, completion: @escaping (Bool, StudyDetailLocationPost?) -> Void) {
        let headers: HTTPHeaders = [ "Authorization": "KakaoAK 6cd40b04c090b1a033634e5051aab78c" ]
        let parameters: Parameters = [
            "x": lng,
            "y": lat
        ]
        
        AF.request("https://dapi.kakao.com/v2/local/geo/coord2address.json",
                   method: .get,
                   parameters: parameters,
                   headers: headers).responseJSON(completionHandler: { response in
                    
                    switch response.result {
                    case .success(let value):
                        if JSON(value)["documents"].count == 0 {
                            completion(false, nil)
                        } else {
                            if let addressList = JSON(value)["documents"].array {
                                for item in addressList {
                                    let addressValid = item["road_address"]["address_name"] != JSON.null
                                    
                                    let address = addressValid ? item["road_address"]["address_name"].string! : item["address"]["address_name"].string!
                                    let region1Depth = addressValid ? item["road_address"]["region_1depth_name"].string! : item["address"]["region_1depth_name"].string!
                                    let region2Depth = addressValid ? item["road_address"]["region_2depth_name"].string! : item["address"]["region_2depth_name"].string!
                                    
                                    let location = StudyDetailLocationPost(address: address,
                                                                           lat: lat,
                                                                           lng: lng,
                                                                           sido: region1Depth,
                                                                           sigungu: region2Depth)
                                    print(location)
                                    
                                    completion(true, location)
                                }
                            }
                        }
                    case .failure(let err) :
                        if let err = err.asAFError {
                            switch err {
                            case .sessionTaskFailed:
                                self.interactor?.sessionTaskError(message: TerminalNetworkManager.shared.sessionTaskErrorMessage)
                            default: break
                            }
                        }
                    }
                   })
        
    }
}
