//
//  SearchStudyRemoteDataManager.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/12/30.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

final class SearchStudyRemoteDataManager: SearchStudyRemoteDataManagerInputProtocol {
    weak var interactor: SearchStudyRemoteDataManagerOutputProtocol?
    
    func getHotKeyword() {
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.hotKeyword)
            .validate() 
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<[HotKeyword]>.self, from: data)
                        self.interactor?.getHotKeywordResult(response: result)
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure(let err):
                    if let err = err.asAFError {
                        switch err {
                        case .sessionTaskFailed:
                            self.interactor?.sessionTaskError(message: TerminalNetworkManager.shared.sessionTaskErrorMessage)
                        default:
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
    }
}
