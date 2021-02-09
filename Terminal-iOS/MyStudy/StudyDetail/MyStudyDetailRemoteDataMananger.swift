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
        //데이터 로직 인터렉터로 옮겨야됨
        
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.studyLeave(studyID: "\(studyID)"))
            .validate(statusCode: 200...422)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = "\(JSON(value))".data(using: .utf8)
                    let result: BaseResponse = try! JSONDecoder().decode(BaseResponse<Bool>.self, from: json!)
                    self.interactor?.leaveStudyResult(result: result.result, message: result.message!)       
                case .failure(let err):
                    print(err.localizedDescription)
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
                case .failure(let err):
                    print(err.localizedDescription)
                }
            }
    }
}
