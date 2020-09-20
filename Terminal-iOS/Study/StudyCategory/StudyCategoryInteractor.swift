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
            Category(name: UIImage(named: "swift")!), Category(name: UIImage(named: "android")!), Category(name: UIImage(named: "tensorflow")!), Category(name: UIImage(named: "node")!), Category(name: UIImage(named: "frontend")!), Category(name: UIImage(named: "android")!), Category(name: UIImage(named: "node")!), Category(name: UIImage(named: "jpark")!), Category(name: UIImage(named: "jpark")!), Category(name: UIImage(named: "jpark")!), Category(name: UIImage(named: "jpark")!), Category(name: UIImage(named: "jpark")!)
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
