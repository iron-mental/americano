//
//  NotificationInteractor.swift
//  Terminal-iOS
//
//  Created by once on 2021/01/27.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation
import SwiftyJSON
import SwiftKeychainWrapper

class NotificationInteractor: NotificationInteractorInputProtocol {
    var presenter: NotificationInteractorOutputProtocol?
    
    func retrieveAlert() {
        guard let userID = KeychainWrapper.standard.string(forKey: "userID") else { return }
        
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.alert(id: userID))
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let data = "\(json)".data(using: .utf8)
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<[Noti]>.self, from: data!)
                        
                        if result.result {
                            if let data = result.data {
                                self.presenter?.didRetrievedAlert(result: data)
                            }
                        } else {
                            self.presenter?.didRetrievedAlert(result: nil)
                        }
                    } catch {
                        print(error)
                    }
                case .failure(let error):
                    print(error)
                }
            }   
    }
}
