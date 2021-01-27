//
//  StudyDetailRemoteManager.swift
//  Terminal-iOS
//
//  Created by once on 2020/11/13.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class StudyDetailRemoteManager: StudyDetailRemoteDataManagerInputProtocol {
    var remoteRequestHandler: StudyDetailRemoteDataManagerOutputProtocol?
    
     func getStudyDetail(studyID: String, completionHandler: @escaping (StudyDetail) -> ()) {
        
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.studyDetail(studyID: studyID))
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = "\(JSON(value))".data(using: .utf8)
                    let result = try! JSONDecoder().decode(BaseResponse<StudyDetail>.self, from: json!)
                    
                    completionHandler(result.data!)
                case .failure(let err):
                    print("실패", err)
                }
            }
    }
    
    func postStudyJoin(studyID: Int, message: String, completion: @escaping (Bool, String) -> Void) {
        
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
                    let message = JSON(value)["message"].string!
                    let result = JSON(value)["result"].bool!
                    completion(result, message)
                    break
                case .failure(let err):
                    print(err)
                    break
                }
            }
    }
}
