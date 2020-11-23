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
        var tempUserID = 1
        
        AF.request("http://3.35.154.27:3000/v1/user/\(tempUserID)/study",
                   method: .get,headers: headers).responseJSON(completionHandler: { [self] response in
                    switch response.result {
                    case .success(let value):
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
    
    static func getStudyDetailInfo(id: Int, completion: @escaping (_: Bool, _: StudyDetailInfo?) -> ()) {
        
        let headers: HTTPHeaders = [ "Authorization": Terminal.accessToken]
        AF.request("http://3.35.154.27:3000/v1/study/\(id)",
                   method: .get,headers: headers).responseJSON(completionHandler: { [self] response in
                    switch response.result {
                    case .success(let value):
                        let json = "\(JSON(value))".data(using: .utf8)
                        let result: StudyDetailInfo = try! JSONDecoder().decode(StudyDetailInfo.self, from: json!)
                        completion(result.result, result)
                    case .failure(let value):
                        print(value)
                    }
                        
                   })
    }
}
//                        var studyInfo = StudyDetailInfo(participants: participants,
//                                        id: json["id"].int!,
//                                        category: json["category"].string!,
//                                        title: json["title"].string!,
//                                        introduce: json["introduce"].string!,
//                                        image: json["image"].string!,
//                                        progress: json["progress"].string!,
//                                        studyTime: json["study_time"].string!,
//                                        snsNotion: json["sns_notion"].string!,
//                                        snsEvernote: json["sns_evernote"].string!,
//                                        snsWeb: json["sns_web"].string!,
//                                        latitude: json["location"]["latitude"].double!,
//                                        longitude: json["location"]["longitude"].double!,
//                                        addressName: json["location"]["address_name"].string!,
//                                        placeName: json["location"]["place_name"].string!,
//                                        locationDetail: json["location"]["location_detail"].string!,
//                                        Authority: json["Authority"].int!)
                        
//                        completion(true, studyInfo)
//                    case .failure(let err) :
//                        print(err)
//                        completion(false, nil)
//                    }
//                   })

