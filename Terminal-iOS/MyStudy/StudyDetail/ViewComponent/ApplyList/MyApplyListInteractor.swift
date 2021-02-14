//
//  MyApplyListInteractor.swift
//  Terminal-iOS
//
//  Created by once on 2020/12/11.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation
import SwiftyJSON
import SwiftKeychainWrapper

class MyApplyListInteractor: MyApplyListInteractorInputProtocol {
    weak var presenter: MyApplyListInteractorOutputProtocol?
    
    func getApplyList() {
        guard let userID = KeychainWrapper.standard.string(forKey: "userID") else { return }
        
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.applyStudyList(id: userID))
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let data = "\(json)".data(using: .utf8)
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<[ApplyStudy]>.self, from: data!)
                        if result.data != nil {
                            self.presenter?.didRetrieveStudies(result: result)
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure:
                    if let data = response.data {
                        do {
                            let result = try JSONDecoder().decode(BaseResponse<[ApplyStudy]>.self, from: data)
                            if result.message != nil {
                                self.presenter?.didRetrieveStudies(result: result)
                            }
                        } catch {
                            
                        }
                    }
                }
            }
    }
}
