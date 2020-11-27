//
//  TerminalAPI.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/16.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class TerminalAPI {
    static func getMyStudyList(completion: @escaping (_:Bool, _: [MyStudy]?) -> ()) {
        let headers: HTTPHeaders = [ "Authorization": Terminal.accessToken]
        var tempUserID = 12
        
        AF.request("http://3.35.154.27:3000/v1/user/\(tempUserID)/study",
                   method: .get,headers: headers).responseJSON(completionHandler: { response in
                    switch response.result {
                    case .success(let value):
                        print(JSON(value))
                        print("이거는?",JSON(value)["result"])
                    let json = JSON(value)["data"]
                        json.array?.forEach { data in
                            if let id = data["id"].int, let title = data["title"].string, let sigungu = data["sigungu"].string, let image = data["image"].string {
                                TempMyStudyList.list.append(MyStudy(id: id, title: title, sigungu: sigungu, image: image))
                            }
                        }
                        completion(true, TempMyStudyList.list)
                    case .failure(let err) :
                        print(err)
                        completion(false, nil)
                    }
                   })
    }
    
    static func getStudyDetailInfo(id: Int, completion: @escaping (_: Bool, _: StudyDetail?) -> ()) {
        
        let headers: HTTPHeaders = [ "Authorization": Terminal.accessToken]
        AF.request("http://3.35.154.27:3000/v1/study/\(id)",
                   method: .get,headers: headers).responseJSON(completionHandler: { response in
                    switch response.result {
                    case .success(let value):
                        let json = "\(JSON(value))".data(using: .utf8)
                        let result: BaseResponse<[StudyDetail]> = try! JSONDecoder().decode(BaseResponse<[StudyDetail]>.self, from: json!)
//                        completion(result.result, result)

                    case .failure(let value):
                        print(value)
                    }
                    
                   })
    }
}
