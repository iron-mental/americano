//
//  NoticeRemoteDataManager.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/25.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NoticeRemoteDataManager: NoticeRemoteDataManagerProtocol {
    
    let headers: HTTPHeaders = [ "Authorization": Terminal.accessToken]
    
    func getNoticeList(studyID: Int, completion: @escaping (Bool, NoticeList?, String?) -> Void) {
        
        AF.request("http://3.35.154.27:3000/v1/study/\(studyID)/notice",
                   method: .get,headers: headers).responseJSON(completionHandler: { [self] response in
                    
                    switch response.result {
                    case .success(let value):
                        if JSON(value)["result"].bool! {
                        let json = "\(JSON(value))".data(using: .utf8)
                        let result: NoticeList = try! JSONDecoder().decode(NoticeList.self, from: json!)
                            completion(true, result, nil)
                        } else {
                            completion(false, nil, JSON(value)["message"].string!)
                        }
                    case .failure(let value):
                        print("에러@@@@@@@@@@@@2")
                        print(value)
                    }
                    
                   })
    }
}
