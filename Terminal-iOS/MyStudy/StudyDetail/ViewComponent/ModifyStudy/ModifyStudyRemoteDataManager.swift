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
        params = [
            "category": study.category,
            "introduce": study.introduce!,
            "progress": study.progress!,
            "study_time": study.studyTime!,
            "sns_notion": study.snsNotion!,
            "sns_evernote": study.snsEvernote!,
            "sns_web": study.snsWeb!
        ]
        
        if let title = study.title {
            params["title"] = title
        }
        if let location = study.location {
            params["address"] = location.address
            params["latitude"] = location.lat
            params["longitude"] = location.lng
            params["sido"] = location.sido
            params["sigungu"] = location.sigungu
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
                    if let imageData = image.jpegData(compressionQuality: 0.1) {
                        multipartFormData.append(imageData,
                                                 withName: "image",
                                                 fileName: "testImage.jpg",
                                                 mimeType: "image/jpeg")
                    }
                }
            }, with: TerminalRouter.studyUpdate(studyID: "\(studyID)", study: params))
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let data = "\(json)".data(using: .utf8)
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<String>.self, from: data!)
                        guard let message = result.message else { return }
                        self.interactor?.putStudyInfoResult(result: result.result, message: message)
                    } catch {
                        self.interactor?.putStudyInfoResult(result: false, message: "실패하였습니다.")
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}
