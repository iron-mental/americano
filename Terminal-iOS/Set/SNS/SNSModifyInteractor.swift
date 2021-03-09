//
//  SNSModifyInteractor.swift
//  Terminal-iOS
//
//  Created by once on 2020/12/22.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

class SNSModifyInteractor: SNSModifyInteractorInputProtocol {
    weak var presenter: SNSModifyInteractorOutputProtocol?
    
    func completeModify(github: String, linkedin: String, web: String) {
        let params: [String: String] = [
            "sns_github": github,
            "sns_linkedin": linkedin,
            "sns_web": web
        ]
        
        guard let userID = KeychainWrapper.standard.string(forKey: "userID") else { return }
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.userSNSUpdate(id: userID, sns: params))
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<Bool>.self, from: data)
                        let isSuccess = result.result
                        let message = result.message!
                        self.presenter?.didCompleteModify(result: isSuccess, message: message)
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure(let err):
                    if let err = err.asAFError {
                        switch err {
                        case .sessionTaskFailed:
                            self.presenter?.sessionTaskError(message: TerminalNetworkManager.shared.sessionTaskErrorMessage)
                        default:
                            let data = response.data
                            do {
                                let result = try JSONDecoder().decode(BaseResponse<Bool>.self, from: data!)
                                let message = result.message!
                                let label = result.label ?? nil
                                self.presenter?.modifyError(label: label, message: message)
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                    }
                }
            }
    }
}
