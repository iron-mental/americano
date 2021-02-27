//
//  NotificationRemoteDataManager.swift
//  Terminal-iOS
//
//  Created by once on 2021/01/28.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

class NotificationRemoteDataManager: NotificationRemoteDataManagerInputProtocol {
    var interactor: NotificationRemoteDataManagerOutputProtocol?
    
    func alertGotConfirmed(userID: Int, alertID: Int) {
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.alertConfirm(userID: userID, alertID: alertID))
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<String>.self, from: data)
                        if result.message != nil {
                            self.interactor?.alertConfirmResult(result: result)
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure:
                    if let data = response.data {
                        do {
                            let result = try JSONDecoder().decode(BaseResponse<String>.self, from: data)
                            if result.message != nil {
                                self.interactor?.alertConfirmResult(result: result)
                            }
                        } catch {
                            
                        }
                    }
                }
            }
    }
    func retrieveAlert() {
        guard let userID = KeychainWrapper.standard.string(forKey: "userID") else { return }
        
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.alert(id: userID))
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<[Noti]>.self, from: data)
                        if result.data != nil {
                            self.interactor?.onRetrievedAlert(result: result)
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure:
                    if let data = response.data {
                        do {
                            let result = try JSONDecoder().decode(BaseResponse<[Noti]>.self, from: data)
                            if result.message != nil {
                                self.interactor?.onRetrievedAlert(result: result)
                            }
                        } catch {
                            
                        }
                    }
                }
            } 
    }
}
