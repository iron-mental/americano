//
//  CareerModifyInteractor.swift
//  Terminal-iOS
//
//  Created by once on 2020/12/22.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper
import SwiftyJSON

class CareerModifyInteractor: CareerModifyInteractorInputProtocol {
    var presenter: CareerModifyInteractorOutputProtocol?
    
    func completeModify(title: String, contents: String) {
        guard let userID = KeychainWrapper.standard.string(forKey: "userID") else { return }
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.userCareerUpdate(id: userID, title: title, contents: contents))
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let data = "\(json)".data(using: .utf8)
                    let result = try! JSONDecoder().decode(BaseResponse<Bool>.self, from: data!)
                    let isSuccess = result.result
                    let message = result.message!
                    self.presenter?.didCompleteModify(result: isSuccess, message: message)
                case .failure(let err):
                    print("error:",err)
                }
            }
    }
}