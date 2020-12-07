//
//  StudyCategoryInteractor.swift
//  Terminal-iOS
//
//  Created by once on 2020/09/14.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class StudyCategoryInteractor: StudyCategoryInteractorInputProtocol {
    var presenter: StudyCategoryInteractorOutputProtocol?
    
    var localDatamanager: StudyCategoryLocalDataManagerInputProtocol?
    
    var remoteDatamanager: StudyCategoryRemoteDataManagerInputProtocol?
    
    func retrieveStudyCategory() {

        let categoryList = [
            Category(image: UIImage(named: "ai")!,name: "set"),
            Category(image: UIImage(named: "android")!,name: "set"),
            Category(image: UIImage(named: "backend")!,name: "set"),
            Category(image: UIImage(named: "blockchain")!,name: "set"),
            Category(image: UIImage(named: "dataengineer")!,name: "set"),
            Category(image: UIImage(named: "desktop")!,name: "set"),
            Category(image: UIImage(named: "devops")!,name: "set"),
            Category(image: UIImage(named: "frontend")!,name: "set"),
            Category(image: UIImage(named: "game")!,name: "set"),
            Category(image: UIImage(named: "ios")!,name: "set"),
            Category(image: UIImage(named: "iot")!,name: "set"),
            Category(image: UIImage(named: "secure")!,name: "set"),
            Category(image: UIImage(named: "network")!,name: "set"),
            Category(image: UIImage(named: "language")!,name: "set"),
            Category(image: UIImage(named: "embeded")!,name: "set")
        ]
        presenter?.didRetrieveCategories(categoryList)
    }
}

extension StudyCategoryInteractor: StudyCategoryRemoteDataManagerOutputProtocol {
    func onCategoriesRetrieved(_ categories: [Category]) {
        
    }
    
    func onError() {
        
    }
}
