//
//  SearchLocationRemoteDataManager.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/10/29.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

struct searchLocationResult {
    var address: String
    var placeName: String?
    var lat: Double
    var lng: Double
    var category: String
}

class SearchLocationRemoteDataManager: SearchLocationRemoteDataManagerProtocol {
    func getSearchResult(text: String, completionHandler: @escaping (_: Bool, _ list: [searchLocationResult]) -> ()) {
        var resultList: [searchLocationResult] = []
        var result = false
        let headers: HTTPHeaders = [ "Authorization": "KakaoAK 6cd40b04c090b1a033634e5051aab78c" ]
        let parameters: [String: String] = [
            "query": text
        ]
        AF.request("https://dapi.kakao.com/v2/local/search/keyword.json",
                   method: .get,
                   parameters: parameters, headers: headers).responseJSON(completionHandler: { [self] response in
                    switch response.result {
                    case .success(let value):
                        if JSON(value)["documents"].count == 0 {
                            result = false
                        } else {
                            if let addressList = JSON(value)["documents"].array {
                                for item in addressList {
                                    let item = searchLocationResult(address: item["road_address_name"].string! ,
                                                                    placeName: item["place_name"].string! ,
                                                                    lat: Double(item["y"].string!) ?? 0,
                                                                    lng: Double(item["x"].string!) ?? 0,
                                                                    category: item["category_group_name"].string!)
                                    resultList.append(item)
                                }
                            }
                            result = true
                        }
                    case .failure(let err) :
                        print(err)
                    }
                    completionHandler(result,resultList)
                   })
    }
}
