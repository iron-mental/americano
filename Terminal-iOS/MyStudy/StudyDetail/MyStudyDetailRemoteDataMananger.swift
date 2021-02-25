//
//  MyStudyDetailRemoteDataMananger.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/24.
//  Copyright © 2020 정재인. All rights reserved.
//

import Alamofire

final class MyStudyDetailRemoteDataManager: MyStudyDetailRemoteDataManagerProtocol {
    weak var interactor: MyStudyDetailInteractorProtocol?
    
    func postLeaveStudyAPI(studyID: Int) {
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.studyLeave(studyID: "\(studyID)"))
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<Bool>.self, from: data)
                        self.interactor?.leaveStudyResult(result: result.result, message: result.message!)
                    } catch {
                        print(error.localizedDescription)
                    }
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
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<Bool>.self, from: data)
                        self.interactor?.deleteStudyResult(result: result.result, message: result.message!)
                    } catch {
                        print(error.localizedDescription)
                    }
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
