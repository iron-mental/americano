//
//  ApplyUserDetailRemoteDataManager.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/15.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation
import SwiftyJSON

class ApplyUserDetailRemoteDataManager: BaseProfileRemoteDataManager, ApplyUserDetailRemoteDataManagerInputProtocol {
    
    func postApplyStatus(studyID: Int, applyID: Int, status: Bool) {
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.applyDetermine(studyID: studyID, applyID: applyID, status: status))
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let data = "\(json)".data(using: .utf8)
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<String>.self, from: data!)
                        if result.message != nil {
                            (self.remoteRequestHandler as! ApplyUserDetailRemoteDataManagerOutputProtocol).onApplyStatusRetrieved(response: result)
                        }
                    } catch {
                        print("error")
                    }
                case .failure:
                    if let data = response.data {
                        do {
                            let result = try JSONDecoder().decode(BaseResponse<String>.self, from: data)
                            if result.message != nil {
                                (self.remoteRequestHandler as! ApplyUserDetailRemoteDataManagerOutputProtocol).onApplyStatusRetrieved(response: result)
                            }
                        } catch {
                            
                        }
                    }
                }
            }
    }
}
