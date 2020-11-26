//
//  CreateStudyRemoteManager.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/25.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import Alamofire



//user_id: 방장 id (require)
//category: 분류 (require)
//title: 길이 2~10 (require)
//introduce: 길이 ~200 (require)
//progress: 길이 ~100 (require)
//study_time: 길이 ~100 (require)
//latitude: 숫자 (require)
//longitude: 숫자 (require)
//region_1depth_name: 길이 ~20 (require)
//region_2depth_name: 길이 ~20 (require)
//address_name: 길이 ~100 (require)
//locaion_detail: 길이 ~30
//place_name: 길이 ~30
//sns_notion: 길이 ~150
//sns_evernote: 길이 ~60
//sns_web: 길이 ~200
//image: jpg, jpeg, png 외 불가


class CreateStudyRemoteManager: CreateStudyRemoteDataManagerProtocols {
    
    
    
    func postStudy(study: StudyDetailPost) -> Bool {
        print(study.location.detailAddress)
        print(study.location.detailAddress!)
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
        print(params)
        
        let header: HTTPHeaders = [ "Content-Type": "multipart/form-data",
                                    "Authorization": Terminal.accessToken]
        
        let imageData = study.image!.jpegData(compressionQuality: 1.0)
        
        AF.upload(multipartFormData: { multipartFormData in
            for (key, value) in params {
                multipartFormData.append("\(value)".data(using: .utf8)!, withName: key, mimeType: "text/plain")
            }
            multipartFormData.append(imageData!, withName: "image", fileName: "\(study.category).jpg", mimeType: "image/jpeg")
        }, to: "http://3.35.154.27:3000/v1/study", method: .post, headers: header).responseJSON { (test) in
            print(test)
        }
        return true
        
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
