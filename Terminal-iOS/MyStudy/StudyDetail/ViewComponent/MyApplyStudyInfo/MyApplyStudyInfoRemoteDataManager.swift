//
//  MyApplyStudyInfoRemoteDataManager.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/29.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation

final class MyApplyStudyInfoRemoteDataManager: MyApplyStudyInfoRemoteDataManagerInputProtocol {
    weak var interactor: MyApplyStudyInfoRemoteDataManagerOutputProtocol?
    
    func deleteApply(studyID: Int, applyID: Int) {
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.applyDelete(studyID: studyID, applyID: applyID))
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<String>.self, from: data)
                        if let message = result.message {
                            self.interactor?.retriveDeleteApplyResult(result: result.result, message: message)
                        }
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
                                    let result = try JSONDecoder().decode(BaseResponse<String>.self, from: data)
                                    if let message = result.message {
                                        self.interactor?.retriveDeleteApplyResult(result: result.result, message: message)
                                    }
                                } catch {
                                    print("error")
                                }
                            }
                        }
                    }
                }
            }
    }
}
