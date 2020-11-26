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
            Category(image: UIImage(named: "swift")!, name: "swift"),
            Category(image: UIImage(named: "frontend")!, name: "frontend"),
            Category(image: UIImage(named: "node")!, name: "node"),
            Category(image: UIImage(named: "android")!, name: "node"),
            Category(image: UIImage(named: "tensorflow")!, name: "node"),
            Category(image: UIImage(named: "swift")!, name: "node"),
            Category(image: UIImage(named: "frontend")!, name: "node"),
            Category(image: UIImage(named: "node")!, name: "node"),
            Category(image: UIImage(named: "android")!, name: "node"),
            Category(image: UIImage(named: "tensorflow")!, name: "node"),
            Category(image: UIImage(named: "swift")!, name: "node"),
            Category(image: UIImage(named: "frontend")!, name: "node"),
            Category(image: UIImage(named: "node")!, name: "node"),
            Category(image: UIImage(named: "android")!, name: "node"),
            Category(image: UIImage(named: "tensorflow")!, name: "node"),
            Category(image: UIImage(named: "swift")!, name: "node"),
            Category(image: UIImage(named: "frontend")!, name: "node"),
            Category(image: UIImage(named: "node")!, name: "node"),
            Category(image: UIImage(named: "android")!, name:  "node"),
            Category(image: UIImage(named: "tensorflow")!, name: "node")
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
