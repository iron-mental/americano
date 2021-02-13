//
//  SearchStudyRemoteDataManager.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/12/30.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation
import SwiftyJSON

class SearchStudyRemoteDataManager: SearchStudyRemoteDataManagerInputProtocol {
    var interactor: SearchStudyRemoteDataManagerOutputProtocol?
    
    func getHotKeyword() {
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.hotKeyword)
            .validate() 
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let data = "\(json)".data(using: .utf8)
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<[HotKeyword]>.self, from: data!)
                        self.interactor?.getHotKeywordResult(response: result)
                    } catch {
                        
                    }
                case .failure:
                    if let data = response.data {
                        do {
                            let result = try JSONDecoder().decode(BaseResponse<[HotKeyword]>.self, from: data)
                            self.interactor?.getHotKeywordResult(response: result)
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }
            }
    }
}
