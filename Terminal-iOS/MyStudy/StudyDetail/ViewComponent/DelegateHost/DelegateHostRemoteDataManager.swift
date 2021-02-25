//
//  DelegateHostRemoteDataManager.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/21.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation

class DelegateHostRemoteDataManager: DelegateHostRemoteDataManagerInputProtocol {
    weak var interactor: DelegateHostRemoteDataManagerOutputProtocol?
    
    func putDelegateHostAPI(studyID: Int, newLeader: Int) {
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.delegateHost(studyID: studyID, newLeader: newLeader))
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<String>.self, from: data)
                        if result.message != nil {
                            self.interactor?.delegateHostResult(response: result)
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure:
                    if let data = response.data {
                        do {
                            let result = try JSONDecoder().decode(BaseResponse<String>.self, from: data)
                            if result.message != nil {
                                self.interactor?.delegateHostResult(response: result)
                            }
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }
            }
    }
}
