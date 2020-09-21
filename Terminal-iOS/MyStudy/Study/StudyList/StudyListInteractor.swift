//
//  StudyListInteractor.swift
//  Terminal-iOS
//
//  Created by once on 2020/09/14.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class StudyListInteractor: StudyListInteractorInputProtocol {
    var presenter: StudyListInteractorOutputProtocol?
    
    var localDataManager: StudyListLocalDataManagerInputProtocol?
    
    var remoteDataManager: StudyListRemoteDataManagerInputProtocol?
    
    func retrieveStudyList() {
        let studies = [
                Study(title: "스니커즈 어플 만드실분", subTitle: "안녕하세요 많은 참여 부탁드립니다.", location: "강남구", date: "09/21 |", managerImage: #imageLiteral(resourceName: "set"), mainImage: #imageLiteral(resourceName: "study")),
                Study(title: "스니커즈 어플 만드실분", subTitle: "안녕하세요 많은 참여 부탁드립니다.", location: "강남구", date: "09/21 |", managerImage: #imageLiteral(resourceName: "study_clicked"), mainImage: #imageLiteral(resourceName: "study_clicked")),
                Study(title: "스니커즈 어플 만드실분", subTitle: "안녕하세요 많은 참여 부탁드립니다.", location: "강남구", date: "09/21 |", managerImage: #imageLiteral(resourceName: "study"), mainImage: #imageLiteral(resourceName: "set")),
                Study(title: "스니커즈 어플 만드실분", subTitle: "안녕하세요 많은 참여 부탁드립니다.", location: "강남구", date: "09/21 |", managerImage: #imageLiteral(resourceName: "mystudy"), mainImage: #imageLiteral(resourceName: "mystudy")),
                Study(title: "스니커즈 어플 만드실분", subTitle: "안녕하세요 많은 참여 부탁드립니다. ", location: "강남구", date: "09/21 |", managerImage: #imageLiteral(resourceName: "categoryimage"), mainImage: #imageLiteral(resourceName: "study_clicked"))
                ]
        presenter?.didRetrieveStudies(studies)
    }
}

extension StudyListInteractor: StudyListRemoteDataManagerOutputProtocol {
    func onStudiesRetrieved(_ studies: [Study]) {
        
    }
    
    func onError() {
        
    }
}
