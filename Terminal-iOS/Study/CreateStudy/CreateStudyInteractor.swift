//
//  CreateStudyInteractor.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/15.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

final class CreateStudyInteractor: CreateStudyInteractorInputProtocol {
    weak var presenter: CreateStudyInteractorOutputProtocol?
    var remoteDataManager: CreateStudyRemoteDataManagerInputProtocol?
    var studyInfo: StudyDetail?
    
    func studyCreateComplete(study: StudyDetailPost, studyID: Int?) {
        let nilCheckResult = StudyCheck.execute(study: study)
        
        if nilCheckResult.message == "성공" {
            remoteDataManager?.postStudy(study: study)
        } else {
            let label = nilCheckResult.label
            let message = nilCheckResult.message
            presenter?.studyInfoInvalid(label: label, message: message)
        }
    }
}

extension CreateStudyInteractor: CreateStudyReMoteDataManagerOutputProtocol {
    func createStudyValid(response: BaseResponse<CreateStudyResult>) {
        switch response.result {
        case true:
            guard let studyID = response.data?.studyID else { return }
            self.presenter?.studyInfoValid(studyID: studyID, message: "스터디 생성완료")
        case false:
            let message = response.message ?? "스터디 생성에 문제가 발생했습니다."
            if let label = response.label {
                self.presenter?.studyInfoInvalid(label: label, message: message)
            } else if let code = response.code, code == 101 {
                self.presenter?.studyInfoInvalid(label: "title", message: message)
            }
        }
    }
    
    func sessionTaskError(message: String) {
        presenter?.sessionTaskError(message: message)
    }
}
