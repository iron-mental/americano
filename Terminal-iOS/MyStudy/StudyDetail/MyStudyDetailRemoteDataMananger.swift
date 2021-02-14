//
//  MyStudyDetailRemoteDataMananger.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/24.
//  Copyright © 2020 정재인. All rights reserved.
//

import Alamofire
import SwiftyJSON

class MyStudyDetailRemoteDataManager: MyStudyDetailRemoteDataManagerProtocol {
    weak var interactor: MyStudyDetailInteractorProtocol?
    
    func postLeaveStudyAPI(studyID: Int) {
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.studyLeave(studyID: "\(studyID)"))
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = "\(JSON(value))".data(using: .utf8)
                    let result: BaseResponse = try! JSONDecoder().decode(BaseResponse<Bool>.self, from: json!)
                    self.interactor?.leaveStudyResult(result: result.result, message: result.message!)       
                case .failure:
                    if let data = response.data {
                        do {
                            let result = try JSONDecoder().decode(BaseResponse<Bool>.self, from: data)
                            self.interactor?.leaveStudyResult(result: result.result, message: result.message!)
                        } catch {
                            
                        }
                    }
                }
            }
    }
    
    func callDeleteStudyAPI(studyID: Int) {
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.studyDelete(studyID: "\(studyID)"))
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = "\(JSON(value))".data(using: .utf8)
                    let result: BaseResponse = try! JSONDecoder().decode(BaseResponse<Bool>.self, from: json!)
                    self.interactor?.deleteStudyResult(result: result.result, message: result.message!)
                case .failure:
                    if let data = response.data {
                        do {
                            let result = try JSONDecoder().decode(BaseResponse<Bool>.self, from: data)
                            self.interactor?.deleteStudyResult(result: result.result, message: result.message!)
                        } catch {
                            
                        }
                    }
                }
            }
    }
}
