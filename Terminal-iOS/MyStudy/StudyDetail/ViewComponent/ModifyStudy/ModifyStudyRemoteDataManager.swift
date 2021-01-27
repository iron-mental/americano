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
        var params: [String: Any] = [:]
        if let location = study.location {
            params = [
                "category": study.category,
                "title": study.title,
                "introduce": study.introduce,
                "progress": study.progress!,
                "study_time": study.studyTime!,
                "sns_notion": study.snsNotion!,
                "sns_evernote": study.snsEvernote!,
                "sns_web": study.snsWeb!,
                "latitude": location.lat,
                "longitude": location.lng,
                "sido": location.sido,
                "sigungu": location.sigungu,
                "address_name": location.address
            ]
            if let detailAddress = location.detailAddress {
                if !detailAddress.isEmpty {
                    params["location_detail"] = detailAddress
                }
            }
            if let placeName =  location.placeName {
                params["place_name"] = placeName
            }
        }

        TerminalNetworkManager
            .shared
            .session
            .upload(multipartFormData: { multipartFormData in
                for (key, value) in params {
                        multipartFormData.append("\(value)".data(using: .utf8)!, withName: key, mimeType: "text/plain")
                }
                if let image = study.image {
                    var imageData = image.jpegData(compressionQuality: 1.0)
                    multipartFormData.append(imageData!, withName: "image", fileName: "\(study.category).jpg", mimeType: "image/jpeg")
                }
                
            }, with: TerminalRouter.studyUpdate(studyID: "\(studyID)", study: params))
            .validate()
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

