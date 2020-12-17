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
            print(study.title)
            return "카테고리 틀려쓰"
        } else if study.title == nil || study.title == "" {
            print(study.title)
            return "타이틀 틀려쓰"
        } else if study.introduce == nil || study.introduce == "" {
            print(study.title)
            return "소개 틀려쓰"
        } else if study.progress == nil || study.progress == "" {
            print(study.title)
            return "계획 틀려쓰"
        } else if study.studyTime == nil || study.studyTime == "" {
            print(study.title)
            return "시간 틀려쓰"
        } else if study.location.lat == nil || study.location.lat.isZero {
            print(study.title)
            return "lat 틀려쓰"
        } else if study.location.lng == nil || study.location.lng.isZero {
            print(study.title)
            return "lng 틀려쓰"
        } else if study.location.address == nil || study.location.address == "" {
            print(study.title)
            return "address 틀려쓰"
        } else {
            return "성공"
        }
    }
    
    func studyInfoOptionalBinding() {
        
    }
    
    func studyCreateComplete(study: StudyDetailPost, state: WriteStudyViewState, studyID: Int?) {
        if nullCheck(study: study) == "성공" {
            switch state {
            case .create:
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
                break
            case .edit:
                createStudyRemoteDataManager?.putStudy(study: study, studyID: studyID!, completion: { result, message in
                    switch result {
                    case true:
                        self.presenter?.studyInfoValid(message: message)
                        break
                    case false:
                        self.presenter?.studyInfoInvalid(message: message)
                        break
                    }
                })
                break
            }
            
        } else {
            presenter?.studyInfoInvalid(message: nullCheck(study: study))
        }
    }
    func viewDidTap(textView: UIView, viewMinY: CGFloat, viewMaxY: CGFloat) {
        var parentView = UIView()
        
        if type(of: textView) == SNSInputUITextField.self {
            parentView = (textView.superview?.superview)!
        } else {
            parentView = textView.superview!
        }
        if viewMinY >= (parentView.frame.minY) {
            let distance = (parentView.frame.minY) - viewMinY
            presenter?.viewDidTapResult(result: true, topOrBottom: true, distance: distance)
        } else if viewMaxY <= (parentView.frame.maxY){
            let distance = (parentView.frame.maxY) - viewMaxY
            presenter?.viewDidTapResult(result: true, topOrBottom: false, distance: distance)
        } else {
            presenter?.viewDidTapResult(result: false, topOrBottom: nil, distance: nil)
        }
    }
}
