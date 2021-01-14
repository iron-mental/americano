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
    
    func getApplyList(studyID: Int) {
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.applyUserList(studyID: "\(studyID)"))
            .validate(statusCode: 200..<299)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    print(JSON(value))
                    let json = JSON(value)
                    let data = "\(json)".data(using: .utf8)
                    let result = try! JSONDecoder().decode(BaseResponse<[ApplyUser]>.self, from: data!)
                    if result.result, let userList = result.data {
                        self.presenter?.didRetrieveUser(userList: userList)
                    }
                case .failure(let err):
                    print("error:",err)
                }
            }
    }
}
