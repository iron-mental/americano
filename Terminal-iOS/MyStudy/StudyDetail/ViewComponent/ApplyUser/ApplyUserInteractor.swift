//
//  ApplyUserInteractor.swift
//  Terminal-iOS
//
//  Created by once on 2020/12/11.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation
import SwiftyJSON
import SwiftKeychainWrapper

class ApplyUserInteractor: ApplyUserInteractorInputProtocol {
    weak var presenter: ApplyUserInteractorOutputProtocol?
    var studyID: Int?
    
    func getApplyList(studyID: Int) {
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.applyUserList(studyID: studyID))
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let data = "\(json)".data(using: .utf8)
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<[ApplyUser]>.self, from: data!)
                        if result.data != nil {
                            self.presenter?.didRetrieveUser(result: result)
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure:
                    if let data = response.data {
                        do {
                            let result = try JSONDecoder().decode(BaseResponse<[ApplyUser]>.self, from: data)
                            if result.message != nil {
                                self.presenter?.didRetrieveUser(result: result)
                            }
                        } catch {
                            
                        }
                    }
                }
            }
    }
}
