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
            guard let message = response.message,
                  let label = response.label else {
                self.presenter?.studyInfoInvalid(label: nil, message: response.message ?? "생성 실패")
                return
            }
            self.presenter?.studyInfoInvalid(label: label, message: message)
        }
    }
}
