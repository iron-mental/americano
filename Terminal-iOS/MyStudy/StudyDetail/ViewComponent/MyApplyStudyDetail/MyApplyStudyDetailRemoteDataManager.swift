//
//  MyApplyStudyDetailRemoteDataManager.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/11.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation
import SwiftyJSON

class MyApplyStudyDetailRemoteDataManager: MyApplyStudyDetailRemoteDataManagerInputProtocol {
    var interactor: MyApplyStudyDetailRemoteDataManagerOutputProtocol?
    
    func getMyApplyStudyDetail(studyID: Int, userID: Int) {
        
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.applyStudyDetail(studyID: studyID, userID: userID))
            .validate(statusCode: 200...422)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let data = "\(json)".data(using: .utf8)
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<ApplyUserResult>.self, from: data!)
                        if let data = result.data {
                            self.interactor?.retriveMyApplyStudyDetail(result: result.result, data: data)
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
    func putNewApplyMessage(studyID: Int, applyID: Int, newMessage: String) {
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.applyModify(studyID: studyID, applyID: applyID, message: newMessage))
            .validate(statusCode: 200...422)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let data = "\(json)".data(using: .utf8)
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<String>.self, from: data!)
                        if let message = result.message {
                            self.interactor?.retriveModifyApplyMessage(result: result.result, message: message)
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
    
    func deleteApply(studyID: Int, applyID: Int) {
        
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.applyDelete(studyID: studyID, applyID: applyID))
            .validate(statusCode: 200...422)
            .responseJSON { response in
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
                        print(error.localizedDescription)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}
