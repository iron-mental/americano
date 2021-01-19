//
//  ModifyStudyRemoteDataManager.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/19.
//  Copyright © 2021 정재인. All rights reserved.
//

import Foundation
import Alamofire

class ModifyStudyRemoteDataManager: ModifyStudyRemoteDataManagerInputProtocol {
    var interactor: ModifyStudyRemoteDataManagerOutputProtocol?
    
    func putStudyInfo(studyID: Int, study: StudyDetailPost) {
        
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
        
//        TerminalNetworkManager
//            .shared
//            .session
//            .request(TerminalRouter.studyUpdate(studyID: studyID, study: ))
    }
}

