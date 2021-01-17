//
//  EmailAuthInteractor.swift
//  Terminal-iOS
//
//  Created by once on 2021/01/17.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper
import SwiftyJSON

class EmailAuthInteractor: EmailAuthInteractorInputProtocol{
    var presenter: EmailAuthInteractorOutputProtocol?
    
    func emailAuthRequest() {
        guard let userID = KeychainWrapper.standard.string(forKey: "userID") else { return }
        
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.emailVerify(id: userID))
            .validate(statusCode: 200...500)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let data = "\(json)".data(using: .utf8)
                    let result = try! JSONDecoder().decode(BaseResponse<Bool>.self, from: data!)
                    let isSuccess = result.result
                    let message = result.message!
                    
                    self.presenter?.eamilAuthResponse(result: isSuccess, message: message)
                case .failure(let error):
                    print(error)
                }
            }
    }
}
