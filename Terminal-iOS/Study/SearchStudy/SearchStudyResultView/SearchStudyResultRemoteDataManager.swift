//
//  SearchStudyResultRemoteDataManager.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/04.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation
import SwiftyJSON

class SearchStudyResultRemoteDataManager: SearchStudyResultRemoteDataManagerInputProtocol {
    weak var interactor: SearchStudyResultRemoteDataManagerOutputProtocol?
    
    func getSearchStudyList(keyWord: String) {
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.studySearch(keyword: keyWord))
            .validate(statusCode: ValidateSequence(startValue: 200, endValue: 422))
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let data = "\(json)".data(using: .utf8)
                    let result = try! JSONDecoder().decode(BaseResponse<[Study]>.self, from: data!)
                    self.interactor?.showSearchStudyListResult(result: result)
                case .failure(let err):
                    print(err)
                }
            }
    }
    
    func getPagingStudyList(keys: [Int]) {
        var params: [String: String] = [ "values": "" ]
        keys.forEach { params["values"]?.append("\($0),") }
        params["values"]?.removeLast()
        
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.studyListForKey(key: params))
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let data = "\(json)".data(using: .utf8)
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<[Study]>.self, from: data!)
                        self.interactor?.showPagingStudyListResult(result: result)
                    } catch {
                        print(error)
                    }
                case .failure(let err):
                    print(err)
                }
            }
    }
    
}
