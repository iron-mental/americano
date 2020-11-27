//
//  CreateStudyInteractor.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/15.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class CreateStudyInteractor: CreateStudyInteractorProtocols {
    
    
    var presenter: CreateStudyPresenterProtocols?
    var createStudyRemoteDataManager: CreateStudyRemoteDataManagerProtocols?
    
    func searchNotionID(id: String?) {
        if let userInput = id {
            if let result = createStudyRemoteDataManager?.getNotionValid(id: userInput) {
                presenter?.showNotionValidResult(result: result)
            }
        }
        
    }
    
    func searchEvernoteURL(url: String?) {
        if let userInput = url {
            if let result = createStudyRemoteDataManager?.getEvernoteValid(url: userInput) {
                presenter?.showEvernoteValidResult(result: result)
            }
        }
    }
    
    func searchWebURL(url: String?) {
        if let userInput = url {
            if let result = createStudyRemoteDataManager?.getWebValid(url: userInput) {
                presenter?.showWebValidResult(result: (result))
            }
        }
    }
    
    func nullCheck(study: StudyDetailPost) -> String {
        if study.category == nil || study.category == ""  {
            return "카테고리 틀려쓰"
        } else if study.title == nil || study.title == "" {
            return "타이틀 틀려쓰"
        } else if study.introduce == nil || study.introduce == "" {
            return "소개 틀려쓰"
        } else if study.progress == nil || study.progress == "" {
            return "계획 틀려쓰"
        } else if study.studyTime == nil || study.studyTime == "" {
            return "시간 틀려쓰"
        } else if study.location.lat == nil || study.location.lat.isZero {
            return "lat 틀려쓰"
        } else if study.location.lng == nil || study.location.lng.isZero {
            return "lng 틀려쓰"
        } else if study.location.sido == nil || study.location.sido == "" {
            return "sido 틀려쓰"
        } else if study.location.sigungu == nil || study.location.sigungu == "" {
            return "sigungu 틀려쓰"
        } else if study.location.address == nil || study.location.address == "" {
            return "address 틀려쓰"
        } else {
            return "스터디가 등록 되었습니다."
        }
    }
    
    func studyCreateComplete(study: StudyDetailPost) {
        if nullCheck(study: study) == "스터디가 등록 되었습니다." {
            createStudyRemoteDataManager?.postStudy(study: study, completion: { result, message in
                switch result {
                case true:
                    self.presenter?.studyInfoValid(message: message)
                    break
                case false:
                    self.presenter?.studyInfoInvalid(message: message)
                    break
                }
            })
        } else {
            presenter?.studyInfoInvalid(message: nullCheck(study: study))
        }
    }
}
