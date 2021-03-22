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
    weak var interactor: SearchLocationInteractorProtocol?
    
    func getSearchResultByKeyword(text: String, completionHandler: @escaping (_: Bool, _ list: [StudyDetailLocationPost]) -> Void) {
        var resultList: [StudyDetailLocationPost] = []
        let headers: HTTPHeaders = [ "Authorization": "KakaoAK 6cd40b04c090b1a033634e5051aab78c" ]
        let parameters: [String: String] = [ "query": text ]
        
        AF.request("https://dapi.kakao.com/v2/local/search/keyword.json",
                   method: .get,
                   parameters: parameters, headers: headers).responseJSON(completionHandler: { response in
                    switch response.result {
                    case .success(let value):
                        if JSON(value)["documents"].count == 0 {
                            self.getSearchResultByLocalName(text: text) { (result, itemList) in
                                completionHandler(result, itemList)
                            }
                        } else {
                            if let addressList = JSON(value)["documents"].array {
                                for item in addressList {
                                    let address = item["road_address_name"].string!.isEmpty ? item["address_name"].string! : item["road_address_name"].string!
                                    let newItem = StudyDetailLocationPost(address: address,
                                                                          lat: Double(item["y"].string!) ?? 0,
                                                                          lng: Double(item["x"].string!) ?? 0,
                                                                          placeName: item["place_name"].string ?? nil ,
                                                                          category: item["category_group_name"].string!
                                    )
                                    resultList.append(newItem)
                                }
                            }
                            completionHandler(true, resultList)
                        }
                    case .failure(let err) :
                        if let err = err.asAFError {
                            switch err {
                            case .sessionTaskFailed:
                                self.interactor?.sessionTaskError(message: TerminalNetworkManager.shared.sessionTaskErrorMessage)
                            default: completionHandler(false, resultList)
                            }
                        }
                    }
                   })
    }
    
    func getSearchResultByLocalName(text: String, completion: @escaping (_: Bool, _: [StudyDetailLocationPost]) -> Void) {
        var resultList: [StudyDetailLocationPost] = []
        let headers: HTTPHeaders = [ "Authorization": "KakaoAK 6cd40b04c090b1a033634e5051aab78c" ]
        let parameters: [String: String] = [ "query": text ]
        var address = ""
        
        AF.request("https://dapi.kakao.com/v2/local/search/address.json",
                   method: .get,
                   parameters: parameters, headers: headers).responseJSON(completionHandler: { response in
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)["documents"]
                        if json.count > 0 {
                            if let addressList = json.array {
                                for item in addressList {
                                    if !item["road_address"].isEmpty {
                                        address = item["road_address"]["address_name"].string!
                                    } else {
                                        address = item["address_name"].string!
                                    }
                                    let newItem = StudyDetailLocationPost(address: address,
                                                                          lat: Double(item["y"].string!) ?? 0,
                                                                          lng: Double(item["x"].string!) ?? 0,
                                                                          placeName: item["road_address"]["building_name"].string ?? "건물명 없음" ,
                                                                          category: ""
                                    )
                                    resultList.append(newItem)
                                }
                            }
                            completion(true, resultList)
                        } else {
                            completion(false, resultList)
                        }
                    case .failure(let err) :
                        if let err = err.asAFError {
                            switch err {
                            case .sessionTaskFailed:
                                self.interactor?.sessionTaskError(message: TerminalNetworkManager.shared.sessionTaskErrorMessage)
                            default: completion(false, resultList)
                            }
                        }
                    }
                   })
    }
}
