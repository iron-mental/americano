//
//  StudyCategoryRemoteManager.swift
//  Terminal-iOS
//
//  Created by once on 2020/09/15.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class StudyCategoryRemoteManager: StudyCategoryRemoteDataManagerInputProtocol {
    weak var interactor: StudyCategoryRemoteDataManagerOutputProtocol?
    
    func retrievePostList() {
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.studyCategory)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<[String]>.self, from: data)
                        self.interactor?.onCategoriesRetrieved(result: result)
                    } catch {
                        print(error)
                    }
                case .failure(let err):
                    if let err = err.asAFError {
                        switch err {
                        case .sessionTaskFailed:
                            self.interactor?.sessionTaskError(message: TerminalNetworkManager.shared.sessionTaskErrorMessage)
                        default:
                            if let data = response.data {
                                do {
                                    let result = try JSONDecoder().decode(BaseResponse<[String]>.self, from: data)
                                    if result.message != nil {
                                        self.interactor?.onCategoriesRetrieved(result: result)
                                    }
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
