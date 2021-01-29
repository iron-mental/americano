//
//  MyApplyStudyInfoRemoteDataManager.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/29.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation
import SwiftyJSON

class MyApplyStudyInfoRemoteDataManager: MyApplyStudyInfoRemoteDataManagerInputProtocol {
    var interactor: MyApplyStudyInfoRemoteDataManagerOutputProtocol?
    
    func deleteApply(studyID: Int, applyID: Int) {
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.applyDelete(studyID: studyID, applyID: applyID))
            .validate()
            .responseJSON { [self] response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let data = "\(json)".data(using: .utf8)
                    
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<String>.self, from: data!)
                        if let message = result.message {
                            self.interactor?.retriveDeleteApplyResult(result: result.result, message: message)
                        }
                    } catch {
                        print("error")
                    }
                    break
                case .failure(let _):
                    interactor?.retriveDeleteApplyResult(result: false, message: "서버와의 연결이 불안정 합니다.")
                    break
                }
            }
    }
}
