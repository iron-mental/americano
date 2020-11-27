//
//  CreateStudyRemoteManager.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/25.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CreateStudyRemoteManager: CreateStudyRemoteDataManagerProtocols {
    
    func postStudy(study: StudyDetailPost, completion: @escaping (Bool, String) -> Void) {
        let params : [String : Any] = [
            "category" : study.category,
            "title" : study.title,
            "introduce" : study.introduce,
            "progress" : study.progress,
            "study_time" : study.studyTime,
            "latitude" : study.location.lat,
            "longitude" : study.location.lng,
            "sido" : study.location.sido!,
            "sigungu" : study.location.sigungu!,
            "address_name" : study.location.address,
            "location_detail" : study.location.detailAddress,
            "place_name" : study.location.placeName,
            "sns_notion" : study.snsNotion! ?? "" ,
            "sns_evernote" : study.snsEvernote! ?? "",
            "sns_web" : study.snsWeb! ?? "",
            "image" : study.image!
        ]
        
        let header: HTTPHeaders = [ "Content-Type": "multipart/form-data",
                                    "Authorization": Terminal.accessToken]
        
        let imageData = study.image!.jpegData(compressionQuality: 1.0)
        
        AF.upload(multipartFormData: { multipartFormData in
            for (key, value) in params {
                multipartFormData.append("\(value)".data(using: .utf8)!, withName: key, mimeType: "text/plain")
            }
            multipartFormData.append(imageData!, withName: "image", fileName: "\(study.category).jpg", mimeType: "image/jpeg")
        }, to: "http://3.35.154.27:3000/v1/study", method: .post, headers: header).responseJSON { (response) in
            
            switch response.result {
            case .success(let value):
                completion(JSON(value)["result"].bool!, JSON(value)["message"].string!)
                break
            case .failure(let err):
                completion(JSON(err)["result"].bool!, JSON(err)["message"].string!)
                break
            }
        }
        
//        AF.upload(
//               multipartFormData: { multipartFormData in
//                for (key, value) in params {
//                    multipartFormData.append("\(value)".data(using: .utf8)!, withName: key, mimeType: "text/plain")
//                }
//                multipartFormData.append(imageData!, withName: "image", fileName: "\(study.category).jpg", mimeType: "image/jpeg")
//               },
//            to:  "http://3.35.154.27:3000/v1/study", method: .post, headers: header)
//        )
    }
    func getNotionValid(id: String?) -> Bool {
        return true
    }
    func getEvernoteValid(url: String?) -> Bool{
        return true
    }
    func getWebValid(url: String?) -> Bool{
        return true
    }
}
