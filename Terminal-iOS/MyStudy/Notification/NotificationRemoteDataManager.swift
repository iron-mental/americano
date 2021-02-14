//
//  NotificationRemoteDataManager.swift
//  Terminal-iOS
//
//  Created by once on 2021/01/28.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation
import SwiftyJSON
import SwiftKeychainWrapper

class NotificationRemoteDataManager: NotificationRemoteDataManagerInputProtocol {
    var interactor: NotificationRemoteDataManagerOutputProtocol?
    
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
                        self.interactor?.onRetrievedAlert(result: result)
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure:
                    if let data = response.data {
                        do {
                            let result = try JSONDecoder().decode(BaseResponse<String>.self, from: data)
                            guard let message = result.message else { return }
                            self.interactor?.retrievedAlertFailed(message: message)
                        } catch {
                            
                        }
                    }
                }
            } 
    }
}
