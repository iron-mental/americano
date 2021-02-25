//
//  CreateStudyRemoteManager.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/25.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation

final class CreateStudyRemoteManager: CreateStudyRemoteDataManagerInputProtocol {
    var interactor: CreateStudyReMoteDataManagerOutputProtocol?
    
    func postStudy(study: StudyDetailPost) {
        var params: [String: Any] = [:]
        
        if let location = study.location {
            params = [
                "category": study.category,
                "title": study.title!,
                "introduce": study.introduce!,
                "progress": study.progress!,
                "study_time": study.studyTime!,
                "sns_notion": study.snsNotion!,
                "sns_evernote": study.snsEvernote!,
                "sns_web": study.snsWeb!,
                "latitude": location.lat,
                "longitude": location.lng,
                "sido": location.sido!,
                "sigungu": location.sigungu!,
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
                    if let imageData = image.jpegData(compressionQuality: 0.1) {
                        multipartFormData.append(imageData,
                                                 withName: "image",
                                                 fileName: "\(image).jpg" ,
                                                 mimeType: "image/jpeg")
                    }
                }
            }, with: TerminalRouter.studyCreate(study: params))
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let result = try JSONDecoder().decode(BaseResponse<CreateStudyResult>.self, from: data)
                        self.interactor?.createStudyValid(response: result)
                    } catch {
                        print(error.localizedDescription)
                    }
                case .failure:
                    if let data = response.data {
                        do {
                            let result = try JSONDecoder().decode(BaseResponse<CreateStudyResult>.self, from: data)
                            self.interactor?.createStudyValid(response: result)
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }
            }
    }
}
