//
//  CreateStudyInteractor.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/15.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class CreateStudyInteractor: CreateStudyInteractorInputProtocol {
    var presenter: CreateStudyInteractorOutputProtocol?
    var remoteDataManager: CreateStudyRemoteDataManagerInputProtocol?
    var studyInfo: StudyDetail?
    
    func nullCheck(study: StudyDetailPost) -> String {
        if study.category.isEmpty {
            return "카테고리가 지정되어있지 않습니다."
        } else if study.title!.isEmpty {
            return "제목을 입력해주세요"
        } else if study.introduce!.isEmpty {
            return "소개를 입력해주세요"
        } else if let notion = study.snsNotion {
            if !notion.notionCheck() {
                return "Notion URL이 정확하지 않습니다."
            }
        }
        if let evernote = study.snsEvernote {
            if !evernote.evernoteCheck() {
                return "Evernote URL이 정확하지 않습니다."
            }
        }
        if let web = study.snsWeb {
            if !web.webCheck() {
                return "Web URL이 정확하지 않습니다."
            }
        }
        if study.progress!.isEmpty {
            return "진행을 입력해주세요"
        }
        if study.location == nil {
            return "장소를 선택해주세요"
        } else if let location = study.location {
            if location.lat.isZero {
                return "장소를 선택해주세요 - latitude error"
            } else if location.lng.isZero {
                return "장소를 선택해주세요 - latitude error"
            } else if location.sido!.isEmpty {
                return "장소를 선택해주세요 - sido 비어있음"
            } else if location.sigungu!.isEmpty {
                return "장소를 선택해주세요 - sigungu 비어있음"
            } else if location.address.isEmpty {
                return "장소를 선택해주세요 - address 비어있음"
            }
        }
        if study.studyTime!.isEmpty {
            return "시간을 입력해주세요"
        }
        return "성공"
    }
    
    func studyCreateComplete(study: StudyDetailPost, studyID: Int?) {
        
        let nullCheckResult = nullCheck(study: study)
        if nullCheckResult == "성공" {
            remoteDataManager?.postStudy(study: study)
        } else {
            presenter?.studyInfoInvalid(message: nullCheckResult)
        }
    }
}

extension CreateStudyInteractor: CreateStudyReMoteDataManagerOutputProtocol {
    func createStudyInvalid(message: String) {
        presenter?.studyInfoInvalid(message: message)
    }
    
    func createStudyValid(response: BaseResponse<CreateStudyResult>) {
        switch response.result {
        case true:
            guard let studyID = response.data?.studyID else { return }
            self.presenter?.studyInfoValid(studyID: studyID)
        case false:
            guard let message = response.message else { return }
            self.presenter?.studyInfoInvalid(message: message)
        }
    }
}
