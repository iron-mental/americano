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
    private let headers: HTTPHeaders = [
        "authorization": Terminal.accessToken
    ]
    
    var remoteRequestHandler: StudyDetailRemoteDataManagerOutputProtocol?
    
    func getStudyDetail(keyValue: String, completionHandler: @escaping (StudyDetail) -> ()) {
        let key = "http://3.35.154.27:3000/v1/study/\(keyValue)"
        
        AF.request(key, headers: headers).responseJSON { response in
            switch response.result {
            case .success(let value):
                print("띠용",JSON(value))
                let json = "\(JSON(value))".data(using: .utf8)
                print(json)
                let result: StudyDetail = try! JSONDecoder().decode(StudyDetail.self, from: json!)
                print("get study detail:",result)
                
                completionHandler(result)
            case .failure(let err):
                print("실패", err)
            }
        }
    }
    
//    func retrievePostList(keyValue: String, completionHandler: @escaping (StudyDetail) -> ()) {
//        TerminalNetwork.getStudyDetail(keyValue) {
//            completionHandler($0)
//        }
//    }
}
