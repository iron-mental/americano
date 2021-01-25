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
    
    func postStudy(study: StudyDetailPost, completion: @escaping (BaseResponse<CreateStudyResult>) -> Void) {
        
        
        let params: [String: Any] = [
            "category" : study.category,
            "title" : study.title,
            "introduce" : study.introduce,
//            "progress" : study.progress!,
//            "study_time" : study.studyTime!,
//            "latitude" : study.location?.lat,
//            "longitude" : study.location?.lng,
//            "sido" : "\(study.location?.sido)",
//            "sigungu" : "\(study.location?.sigungu)",
//            "address_name" : study.location?.address ?? "",
//            "location_detail" : (study.location?.detailAddress)!,
//            "place_name" : study.location?.placeName ?? "",
//            "sns_notion" : study.snsNotion!,
//            "sns_evernote" : study.snsEvernote!,
//            "sns_web" : study.snsWeb!
//            "category" : "ios",
//            "title" : "535466",
//            "introduce" : "2345",
            "progress" : "5554",
            "study_time" : "2345",
            "latitude" : "36",
            "longitude" : "127",
            "sido" : "\(study.location?.sido)",
            "sigungu" : "\(study.location?.sigungu)",
            "address_name" : study.location?.address ?? "",
            "location_detail" : "304호",
            "place_name" : "랄라",
            "sns_notion" : "",
            "sns_evernote" : "",
            "sns_web" : ""
        ]
        
        
        let imageData = study.image!.jpegData(compressionQuality: 1.0)
        TerminalNetworkManager
            .shared
            .session
            .upload(multipartFormData: { multipartFormData in
                for (key, value) in params {
                        multipartFormData.append("\(value)".data(using: .utf8)!, withName: key, mimeType: "text/plain")
                }
                
                multipartFormData.append(imageData!, withName: "image", fileName: "\(study.category).jpg", mimeType: "image/jpeg")
            }, with: TerminalRouter.studyCreate(study: params))
            .validate(statusCode: 200..<503)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let data = "\(json)".data(using: .utf8)
                    
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<CreateStudyResult>.self, from: data!)
                        completion(result)
                    } catch {
                        print("error~~~")
                    }
                    break
                case .failure(let err):
                    print(err)
                    break
                }
            }
    }
    
    func putStudy(study: StudyDetailPost, studyID: Int, completion: @escaping (Bool, String) -> Void) {
        
//        let params: [String: String] = [
//            "category" : study.category != nil ? study.category : "",
//            "title" : study.title != nil ? study.title : "",
//            "introduce" : study.introduce != nil ? study.introduce : "",
//            "progress" : study.progress != nil ? study.progress as! String : "",
//            "study_time" : study.studyTime != nil ? study.studyTime as! String : "",
        //            "latitude" : study.location?.lat != nil ? String(study.location.lat) : "",
        //            "longitude" : study.location?.lng != nil ? String(study.location.lng) : "",
        //            "sido" : study.location?.sido != nil ? study.location.sido : "",
        //            "sigungu" : study.location?.sigungu != nil ? study.location.sigungu : "",
        //            "address_name" : study.location?.address != nil ? study.location.address : "",
        //            "location_detail" : study.location?.detailAddress != nil ? study.location?.detailAddress! : "",
        //            "place_name" : study.location?.placeName != nil ? study.location?.placeName! : "",
//            "sns_notion" : study.snsNotion != nil ? study.snsNotion! : "",
//            "sns_evernote" : study.snsEvernote != nil ? study.snsEvernote! : "",
//            "sns_web" : study.snsWeb != nil ? study.snsWeb! : "",
//            "image" : "\(study.image)"
//        ]
        
        _ = study.image!.jpegData(compressionQuality: 1.0)
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
