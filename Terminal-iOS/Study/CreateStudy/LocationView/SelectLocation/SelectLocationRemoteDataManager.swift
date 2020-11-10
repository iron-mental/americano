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

class SelectLocationRemoteDataManager: SelectLocationRemoteDataManagerProtocol {
    func getAddressInfo(lat: Double, lng: Double, completion: @escaping (Bool, searchLocationResult?) -> ()) {
        //api ㅆ고
        let headers: HTTPHeaders = [ "Authorization": "KakaoAK 6cd40b04c090b1a033634e5051aab78c" ]
        let parameters: Parameters = [
            "x" : lng,
            "y" : lat
        ]
        
        AF.request("https://dapi.kakao.com/v2/local/geo/coord2address.json",
                   method: .get,
                   parameters: parameters, headers: headers).responseJSON(completionHandler: { [self] response in
                    
                    switch response.result {
                    case .success(let value):
                        if JSON(value)["documents"].count == 0 {
                            completion(false, nil)
                        } else {
                            if let addressList = JSON(value)["documents"].array {
                                
                                
                                
                                for item in addressList {
                                    let addressValid = item["road_address"]["address_name"] != JSON.null
                                    
                                    let address = addressValid ? item["road_address"]["address_name"].string! : item["address"]["address_name"].string!
                                    let  region1Depth = addressValid ? item["road_address"]["region_1depth_name"].string! : item["address"]["region_1depth_name"].string!
                                    let region2Depth = addressValid ? item["road_address"]["region_2depth_name"].string! : item["address"]["region_2depth_name"].string!
                                    
//                                    if item["road_address"]["address_name"] != JSON.null {
//                                        address = item["road_address"]["address_name"].string!
//                                        region1Depth = item["road_address"]["region_1depth_name"].string!
//                                        region2Depth = item["road_address"]["region_2depth_name"].string!
//                                    } else {
//                                        address = item["address"]["address_name"].string!
//                                        region1Depth = item["address"]["region_1depth_name"].string!
//                                        region2Depth = item["address"]["region_2depth_name"].string!
//                                    }
                                    
                                    
                                    
                                    completion(true, searchLocationResult(address: address,
                                                                          lat: lat,
                                                                          lng: lng,
                                                                          region_1depth_name: region1Depth,
                                                                          region_2depth_name: region2Depth))
                                }
                            }
                        }
                    case .failure(let err) :
                        print(err)
                    }
                   })
        
    }
}
