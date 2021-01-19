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
        
        let params: [String: String] = [
            "category" : study.category != nil ? study.category : "",
            "title" : study.title != nil ? study.title : "",
            "introduce" : study.introduce != nil ? study.introduce : "",
            "progress" : study.progress != nil ? study.progress : "",
            "study_time" : study.studyTime != nil ? study.studyTime : "",
            "latitude" : study.location.lat != nil ? String(study.location.lat) : "",
            "longitude" : study.location.lng != nil ? String(study.location.lng) : "",
            "sido" : study.location.sido != nil ? study.location.sido : "",
            "sigungu" : study.location.sigungu != nil ? study.location.sigungu : "",
            "address_name" : study.location.address != nil ? study.location.address : "",
            "location_detail" : study.location.detailAddress != nil ? study.location.detailAddress! : "",
            "place_name" : study.location.placeName != nil ? study.location.placeName! : "",
            "sns_notion" : study.snsNotion != nil ? study.snsNotion! : "",
            "sns_evernote" : study.snsEvernote != nil ? study.snsEvernote! : "",
            "sns_web" : study.snsWeb != nil ? study.snsWeb! : "",
            "image" : "\(study.image)"
        ]
        
        let imageData = study.image!.jpegData(compressionQuality: 1.0)
        
//        category: 분류 (require)
//        title: 길이 2~10 (require)
//        introduce: 길이 ~200 (require)
//        progress: 길이 ~100 (require)
//        study_time: 길이 ~100 (require)
//        latitude: 숫자 (require)
//        longitude: 숫자 (require)
//        sido: 길이 ~20 (require)
//        sigungu: 길이 ~20 (require)
//        address_name: 길이 ~100 (require)
//        locaion_detail: 길이 ~30
////        place_name: 길이 ~30
////        sns_notion: 길이 ~170
////        sns_evernote: 길이 ~170
////        sns_web: 길이 ~170
//        image: jpg, jpeg, png 외 불가

        TerminalNetworkManager
            .shared
            .session
            .upload(multipartFormData: { multipartFormData in
                for (key, value) in params {
                    if value != nil && value != "" && value != "nil" {

                        multipartFormData.append("\(value)".data(using: .utf8)!, withName: key, mimeType: "text/plain")
                    }
                }
                
                multipartFormData.append(imageData!, withName: "image", fileName: "\(study.category).jpg", mimeType: "image/jpeg")
            }, with: TerminalRouter.studyCreate(study: params))
            .validate(statusCode: 200..<299)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    
                    completion(JSON(value)["result"].bool!, JSON(value)["message"].string ?? "")
                    break
                case .failure(let err):
                    
                    completion(JSON(err)["result"].bool!, JSON(err)["message"].string!)
                    break
                }
            }
    }
    
    func putStudy(study: StudyDetailPost, studyID: Int, completion: @escaping (Bool, String) -> Void) {
        
        let params: [String: String] = [
            "category" : study.category != nil ? study.category : "",
            "title" : study.title != nil ? study.title : "",
            "introduce" : study.introduce != nil ? study.introduce : "",
            "progress" : study.progress != nil ? study.progress : "",
            "study_time" : study.studyTime != nil ? study.studyTime : "",
            "latitude" : study.location.lat != nil ? String(study.location.lat) : "",
            "longitude" : study.location.lng != nil ? String(study.location.lng) : "",
            "sido" : study.location.sido != nil ? study.location.sido : "",
            "sigungu" : study.location.sigungu != nil ? study.location.sigungu : "",
            "address_name" : study.location.address != nil ? study.location.address : "",
            "location_detail" : study.location.detailAddress != nil ? study.location.detailAddress! : "",
            "place_name" : study.location.placeName != nil ? study.location.placeName! : "",
            "sns_notion" : study.snsNotion != nil ? study.snsNotion! : "",
            "sns_evernote" : study.snsEvernote != nil ? study.snsEvernote! : "",
            "sns_web" : study.snsWeb != nil ? study.snsWeb! : "",
            "image" : "\(study.image)"
        ]
        
        let imageData = study.image!.jpegData(compressionQuality: 1.0)
        
        TerminalNetworkManager
            .shared
            .session
            .upload(multipartFormData: { multipartFormData in
                for (key, value) in params {
                    if value != nil && value != "" && value != "nil" && value != "same" {
                        multipartFormData.append("\(value)".data(using: .utf8)!, withName: key, mimeType: "text/plain")
                    }
                }
                multipartFormData.append(imageData!, withName: "image", fileName: "\(study.category).jpg", mimeType: "image/jpeg")
            }, with: TerminalRouter.studyUpdate(studyID: "\(studyID)"))
            .validate(statusCode: 200..<299)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    
                    print(JSON(value))
                    completion(JSON(value)["result"].bool!, JSON(value)["message"].string ?? "")
                    break
                case .failure(let err):
                    
                    completion(JSON(err)["result"].bool!, JSON(err)["message"].string!)
                    break
                }
            }
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
