//
//  ModifyStudyRemoteDataManager.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/19.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ModifyStudyRemoteDataManager: ModifyStudyRemoteDataManagerInputProtocol {
    var interactor: ModifyStudyRemoteDataManagerOutputProtocol?
    
    func putStudyInfo(studyID: Int, study: StudyDetailPost) {
        
        let params: [String: String] = [
            "category" : study.category,
            "title" : study.title,
            "introduce" : study.introduce,
            "progress" : study.progress!,
            "study_time" : study.studyTime!,
            "latitude" : "\(study.location?.lat)",
            "longitude" : "\(study.location?.lng)",
            "sido" : "\(study.location?.sido)",
            "sigungu" : "\(study.location?.sigungu)",
            "address_name" : study.location?.address ?? "",
            "location_detail" : (study.location?.detailAddress)!,
            "place_name" : (study.location?.placeName)!,
            "sns_notion" : study.snsNotion!,
            "sns_evernote" : study.snsEvernote!,
            "sns_web" : study.snsWeb!,
        ]
        
        TerminalNetworkManager
            .shared
            .session
            .upload(multipartFormData: { multipartFormData in
                for (key, value) in params {
                    if value != nil && value != "" && value != "nil" && value != "same" {
                        
                        multipartFormData.append("\(value)".data(using: .utf8)!, withName: key, mimeType: "text/plain")
                    }
                }
                if let image = study.image {
                    var imageData = image.jpegData(compressionQuality: 1.0)
                    multipartFormData.append(imageData!, withName: "image", fileName: "\(study.category).jpg", mimeType: "image/jpeg")
                }
                
            }, with: TerminalRouter.studyUpdate(studyID: "\(studyID)", study: params))
            .validate(statusCode: 200..<500)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    print(JSON(value))
                    
                    
                    break
                case .failure(let err):
                    
                    break
                }
            }
    }
}

