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
        } else if study.progress.isEmpty {
            return "진행 비어있음"
        } else if study.studyTime.isEmpty {
            return "시간 비어있음"
        } else if study.location.lat.isZero {
            return "latitude 비어있음"
        } else if study.location.lng.isZero {
            return "longitude 비어있음"
        } else if study.location.sido.isEmpty {
            return "sido 비어있음"
        } else if study.location.sigungu.isEmpty {
            return "sigungu 비어있음"
        } else if study.location.address.isEmpty {
            return "address 비어있음"
        } else {
            return "성공"
        }
    }
        
    func studyInfoOptionalBinding() {
        
    }
    
    func studyCreateComplete(study: StudyDetailPost, studyID: Int?) {
        print(nullCheck(study: study))
        if nullCheck(study: study) == "성공" {
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
