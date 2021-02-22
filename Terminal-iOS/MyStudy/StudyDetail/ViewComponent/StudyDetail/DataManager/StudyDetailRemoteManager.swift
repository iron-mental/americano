//
//  StudyDetailRemoteManager.swift
//  Terminal-iOS
//
//  Created by once on 2020/11/13.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation
import SwiftyJSON

class StudyDetailRemoteManager: StudyDetailRemoteDataManagerInputProtocol {
    weak var remoteRequestHandler: StudyDetailRemoteDataManagerOutputProtocol?
    
    func getStudyDetail(studyID: String) {
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.studyDetail(studyID: studyID))
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let data = "\(json)".data(using: .utf8)
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<StudyDetailInfo>.self, from: data!)
                        if result.data != nil {
                            self.remoteRequestHandler?.onStudyDetailRetrieved(result: result)
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure:
                    if let data = response.data {
                        do {
                            let result = try JSONDecoder().decode(BaseResponse<StudyDetailInfo>.self, from: data)
                            if result.message != nil {
                                self.remoteRequestHandler?.onStudyDetailRetrieved(result: result)
                            }
                        } catch {
                            
                        }
                    }
                }
            }
    }
    
    func postStudyJoin(studyID: Int, message: String) {
        
        let params: [String: String] = [
            "message": message
        ]
        
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.applyStudy(studyID: String(studyID), message: params))
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let data = "\(json)".data(using: .utf8)
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<String>.self, from: data!)
                        if result.message != nil {
                            self.remoteRequestHandler?.postStudyJoinResult(result: result)
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure:
                    if let data = response.data {
                        do {
                            let result = try JSONDecoder().decode(BaseResponse<String>.self, from: data)
                            if result.message != nil {
                                self.remoteRequestHandler?.postStudyJoinResult(result: result)
                            }
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }
            }
    }
}
