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
    var presenter: ApplyUserInteractorOutputProtocol?
    var studyID: Int?
    
    func getApplyList(studyID: Int) {
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.applyUserList(studyID: studyID))
            .validate(statusCode: 200...422)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let data = "\(json)".data(using: .utf8)
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<[ApplyUser]>.self, from: data!)
                        
                        if result.result, let userList = result.data {
                            self.presenter?.didRetrieveUser(userList: userList)
                        } else {
                            self.presenter?.didRetrieveUser(userList: [])
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}
