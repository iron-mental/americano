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
    var studyInfo: StudyDetail?
    
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
        
        if study.category.isEmpty {
            return "카테고리 비어있음"
        } else if study.title.isEmpty {
            return "제목 비어있음"
        } else if study.introduce.isEmpty {
            return "소개 비어있음"
        } else if study.progress!.isEmpty {
            return "진행 비어있음"
        } else if study.studyTime!.isEmpty {
            return "시간 비어있음"
        } else if study.location == nil {
            return "장소를 선택해주세요"
        } else if let location = study.location {
            if location.lat.isZero {
                return "장소를 선택해주세요 - latitude error"
            } else if location.lng.isZero {
                return "장소를 선택해주세요 - latitude error"
            } else if location.sido.isEmpty {
                return "장소를 선택해주세요 - sido 비어있음"
            } else if location.sigungu.isEmpty {
                return "장소를 선택해주세요 - sigungu 비어있음"
            } else if location.address.isEmpty {
                return "장소를 선택해주세요 - address 비어있음"
            }
        }
        return "성공"
    }
    
    func studyInfoOptionalBinding() {
        
    }
    
    func studyCreateComplete(study: StudyDetailPost, studyID: Int?) {
        let nullCheckResult = nullCheck(study: study)
        
        if nullCheckResult == "성공" {
            
            
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
            presenter?.studyInfoInvalid(message: nullCheckResult)
        }
    }
}
