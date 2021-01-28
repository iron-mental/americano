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
    var remoteRequestHandler: StudyDetailRemoteDataManagerOutputProtocol?
    
     func getStudyDetail(studyID: String, completionHandler: @escaping (StudyDetail) -> ()) {
        TerminalNetworkManager
            .shared
            .session
            .request(TerminalRouter.studyDetail(studyID: studyID))
            .validate(statusCode: 200...422)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let data = "\(json)".data(using: .utf8)
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<StudyDetail>.self, from: data!)
                        
                        completionHandler(result.data!)
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure(let error):
                    print("실패", error.localizedDescription)
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
            .validate(statusCode: 200...422)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let message = JSON(value)["message"].string!
                    let result = JSON(value)["result"].bool!
                    completion(result, message)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}
