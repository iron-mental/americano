//
//  SearchStudyResultRemoteDataManager.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/04.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation

final class SearchStudyResultRemoteDataManager: SearchStudyResultRemoteDataManagerInputProtocol {
    weak var interactor: SearchStudyResultRemoteDataManagerOutputProtocol?
    
    func getSearchStudyList(keyWord: String) {
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.studySearch(keyword: keyWord))
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<[Study]>.self, from: data)
                        self.interactor?.showSearchStudyListResult(result: result)
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
                                    let result = try JSONDecoder().decode(BaseResponse<[Study]>.self, from: data)
                                    self.interactor?.showSearchStudyListResult(result: result)
                                } catch {
                                    print(error.localizedDescription)
                                }
                            }
                        }
                    }
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
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<[Study]>.self, from: data)
                        self.interactor?.showPagingStudyListResult(result: result)
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
                                    let result = try JSONDecoder().decode(BaseResponse<[Study]>.self, from: data)
                                    self.interactor?.showSearchStudyListResult(result: result)
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
