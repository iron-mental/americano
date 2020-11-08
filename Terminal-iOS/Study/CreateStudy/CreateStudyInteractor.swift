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
    
    func studyCreateComplete(image: UIImage, userID: Int, category: String, title: String, introduce: String, progress: String, studyTime: String, location: String, notion: String, everNote: String, web: String) {
        //remoteDataManager로 보내기 전에 비어있는 값이 있는 지 확인 후 있다면 remoteDataManager로 보내지말고 presenter에게 알려주어야 겠죠??
        //그 처리는 나중에 해주도록 합시다
        let studyInfo = StudyInfo(image: image, userID: userID, category: category, title: title, introduce: introduce, progress: progress, studyTime: studyTime, location: location, notion: notion, everNote: everNote, web: web)
        createStudyRemoteDataManager?.postStudy(studyInfo: studyInfo)
    }
}
