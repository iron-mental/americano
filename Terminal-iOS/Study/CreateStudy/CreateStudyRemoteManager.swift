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

class CreateStudyRemoteManager: CreateStudyRemoteDataManagerInputProtocol {
    var interactor: CreateStudyReMoteDataManagerOutputProtocol?
    
    func postStudy(study: StudyDetailPost) {
        var params: [String: Any] = [:]
        if let location = study.location {
            params = [
                "category" : study.category,
                "title" : study.title,
                "introduce" : study.introduce,
                "progress" : study.progress!,
                "study_time" : study.studyTime!,
                "sns_notion" : study.snsNotion!,
                "sns_evernote" : study.snsEvernote!,
                "sns_web" : study.snsWeb!,
                "latitude" : location.lat,
                "longitude" : location.lng,
                "sido" : location.sido,
                "sigungu" : location.sigungu,
                "address_name" : location.address,
                "location_detail" : location.detailAddress,
                "place_name" : location.placeName
            ]
        }
        
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
                        self.interactor?.createStudyValid(response: result)
                    } catch {
                        
                    }
                case .failure(_):
                    //이 텍스트를 프레젠터에서 넣어줘야될지 음 정하면댈듯
                    self.interactor?.createStudyInvalid(message: "서버의 연결이 불안정합니다")
                }
            }
    }
}
