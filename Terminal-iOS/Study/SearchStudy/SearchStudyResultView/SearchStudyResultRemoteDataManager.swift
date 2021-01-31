//
//  SearchStudyResultRemoteDataManager.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/04.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation
import SwiftyJSON

class SearchStudyResultRemoteDataManager: SearchStudyResultRemoteDataManagerProtocol {
    var interactor: SearchStudyResultInteractorProtocol?
    
    func getSearchStudyResult(keyWord: String) {
        
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
                    
                    self.interactor?.showSearchStudyResult(result: result)
                case .failure(let err):
                    
                    print(err)
                }
            }
    }
}
