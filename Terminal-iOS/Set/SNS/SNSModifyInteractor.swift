//
//  SNSModifyInteractor.swift
//  Terminal-iOS
//
//  Created by once on 2020/12/22.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper
import SwiftyJSON

class SNSModifyInteractor: SNSModifyInteractorInputProtocol {
    var presenter: SNSModifyInteractorOutputProtocol?
    
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
            .validate(statusCode: 200..<500)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    print(JSON(value))
                    let json = JSON(value)
                    let data = "\(json)".data(using: .utf8)
                    let result = try! JSONDecoder().decode(BaseResponse<Bool>.self, from: data!)
                    let isSuccess = result.result
                    let message = result.message!
                    self.presenter?.didCompleteModify(result: isSuccess, message: message)
                case .failure(let err):
                    print(err)
                }
            }
    }
}
