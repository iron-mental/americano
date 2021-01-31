//
//  DelegateHostRemoteDataManager.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/21.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation
import SwiftyJSON

class DelegateHostRemoteDataManager: DelegateHostRemoteDataManagerInputProtocol {
    var interactor: DelegateHostRemoteDataManagerOutputProtocol?
    
    func putDelegateHostAPI(studyID: Int, newLeader: Int) {
        
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.delegateHost(studyID: studyID, newLeader: newLeader))
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let data = "\(json)".data(using: .utf8)
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<String>.self, from: data!)
                        if let message = result.message {
                            self.interactor?.delegateHostResult(response: result)
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure(let err):
                    print(err.localizedDescription)
                }
            }
    }
}
