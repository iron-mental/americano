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

class SearchLocationRemoteDataManager: SearchLocationRemoteDataManagerProtocol {
    func getSearchResult(text: String, completionHandler: @escaping (_: Bool, _ list: [StudyDetailLocationPost]) -> Void) {
        var resultList: [StudyDetailLocationPost] = []
        var result = false
        let headers: HTTPHeaders = [ "Authorization": "KakaoAK 6cd40b04c090b1a033634e5051aab78c" ]
        let parameters: [String: String] = [
            "query": text
        ]
        
        AF.request("https://dapi.kakao.com/v2/local/search/keyword.json",
                   method: .get,
                   parameters: parameters, headers: headers).responseJSON(completionHandler: { response in
                    switch response.result {
                    case .success(let value):
                        if JSON(value)["documents"].count == 0 {
                            result = false
                        } else {
                            if let addressList = JSON(value)["documents"].array {
                                for item in addressList {
                                    let address = item["road_address_name"].string!.isEmpty ? item["address_name"].string! : item["road_address_name"].string!
                                    
                                    let newItem = StudyDetailLocationPost(address: address,
                                                                    lat: Double(item["y"].string!) ?? 0,
                                                                    lng: Double(item["x"].string!) ?? 0,
                                                                    placeName: item["place_name"].string ?? nil ,
                                                                    category: item["category_group_name"].string!,
                                                                    sido: "test",
                                                                    sigungu: "Test"
                                                                    )
                                    resultList.append(newItem)
                                }
                            }
                            result = true
                        }
                    case .failure(let err) :
                        print(err)
                    }
                    completionHandler(result, resultList)
                   })
    }
}
