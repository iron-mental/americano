//
//  CareerModifyInteractor.swift
//  Terminal-iOS
//
//  Created by once on 2020/12/22.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

class CareerModifyInteractor: CareerModifyInteractorInputProtocol {
    var presenter: CareerModifyInteractorOutputProtocol?
    
    func completeModify(title: String, contents: String) {
        let params = [
            "career_title": title,
            "career_contents": contents
        ]
        
        guard let userID = KeychainWrapper.standard.string(forKey: "userID") else { return }
        
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.userCareerUpdate(id: userID, career: params))
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
