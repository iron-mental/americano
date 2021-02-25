//
//  EmailModifyInteractor.swift
//  Terminal-iOS
//
//  Created by once on 2020/12/22.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

class EmailModifyInteractor: EmailModifyInteractorInputProtocol {
    var presenter: EmailModifyInteractorOutputProtocol?
    
    func completeModify(email: String) {
        guard let userID = KeychainWrapper.standard.string(forKey: "userID") else { return }
        
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.emailAuth(id: userID, email: email))
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
                case .failure:
                    let data = response.data
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<Bool>.self, from: data!)
                        let isSuccess = result.result
                        let message = result.message!
                        self.presenter?.didCompleteModify(result: isSuccess, message: message)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
    }
}
