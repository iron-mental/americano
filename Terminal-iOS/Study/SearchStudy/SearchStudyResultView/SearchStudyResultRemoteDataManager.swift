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
    var interactor: SearchStudyResultRemoteDataManagerOutputProtocol?
    
    func getSearchStudyList(keyWord: String) {
        
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.studySearch(keyword: keyWord))
            .validate()
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
        print(keys)
    }
    
}
