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
    func postStudy(studyInfo: StudyInfo) -> Bool {
        let params : [String : Any] = [
            "user_id" : studyInfo.userID,
            "category" : studyInfo.category,
            "title" : studyInfo.title,
            "introduce" : studyInfo.introduce,
            "progress" : studyInfo.progress,
            "study_time" : studyInfo.studyTime,
            "latitude" : studyInfo.notion,
            "longitude" : studyInfo.everNote,
            "region_1depth_name" : studyInfo.web,
            "region_2depth_name" : studyInfo.location,
            "address_name" : studyInfo.location,
            "locaion_detail" : studyInfo.location,
            "place_name" : studyInfo.location,
            "sns_notion" : studyInfo.notion ,
            "sns_evernote" : studyInfo.everNote,
            "sns_web" : studyInfo.web,
            "image" : studyInfo.image
        ]
        var urlComponent = URLComponents(string: "http://3.35.154.27:3000/v1/study")
        let header: HTTPHeaders = [ "Content-Type": "multipart/form-data" ]
        guard let url = urlComponent?.url else { return true }
        let imageData = studyInfo.image.jpegData(compressionQuality: 1.0)
        AF.upload(multipartFormData: { multipartFormData in
            for (key, value) in params {
                multipartFormData.append("\(value)".data(using: .utf8)!, withName: key, mimeType: "text/plain")
            }
            multipartFormData.append(imageData!, withName: "image", fileName: "\(studyInfo.userID).jpg", mimeType: "image/jpeg")
        }, to: url, method: .post, headers: header) { result in
            dump(result)
        }.resume()
        return true
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
