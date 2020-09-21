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
                Study(title: "스니커즈 어플 만드실분", subTitle: "안녕하세요 많은 참여 부탁드립니다.", location: "강남구", date: "09/21 |", managerImage: #imageLiteral(resourceName: "Image-1"), mainImage: #imageLiteral(resourceName: "Image")),
                Study(title: "스니커즈 어플 만드실분", subTitle: "안녕하세요 많은 참여 부탁드립니다.", location: "강남구", date: "09/21 |", managerImage: #imageLiteral(resourceName: "Image-1"), mainImage: #imageLiteral(resourceName: "Image")),
                Study(title: "스니커즈 어플 만드실분", subTitle: "안녕하세요 많은 참여 부탁드립니다.", location: "강남구", date: "09/21 |", managerImage: #imageLiteral(resourceName: "Image-1"), mainImage: #imageLiteral(resourceName: "Image")),
                Study(title: "스니커즈 어플 만드실분", subTitle: "안녕하세요 많은 참여 부탁드립니다.", location: "강남구", date: "09/21 |", managerImage: #imageLiteral(resourceName: "Image-1"), mainImage: #imageLiteral(resourceName: "Image")),
                Study(title: "스니커즈 어플 만드실분", subTitle: "안녕하세요 많은 참여 부탁드립니다. ", location: "강남구", date: "09/21 |", managerImage: #imageLiteral(resourceName: "Image-1"), mainImage: #imageLiteral(resourceName: "Image"))
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
