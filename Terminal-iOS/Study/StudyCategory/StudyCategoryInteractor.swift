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
//        let categoryList = [
//            Category(image: UIImage(named: "ios")!,name: "ios"),
//            Category(image: UIImage(named: "ai")!, name: "ai"),
//            Category(image: UIImage(named: "android")!, name: "android"),
//            Category(image: UIImage(named: "backend")!, name: "backend"),
//            Category(image: UIImage(named: "blockchain")!, name: "blockchain"),
//            Category(image: UIImage(named: "bigdata")!, name: "bigdata"),
//            Category(image: UIImage(named: "desktop")!, name: "desktop"),
//            Category(image: UIImage(named: "devops")!, name: "devops"),
//            Category(image: UIImage(named: "web")!, name: "web"),
//            Category(image: UIImage(named: "game")!, name: "game"),
//            Category(image: UIImage(named: "iot")!, name: "iot"),
//            Category(image: UIImage(named: "secure")!, name: "secure"),
//            Category(image: UIImage(named: "systemNetwork")!, name: "systemNetwork"),
//            Category(image: UIImage(named: "language")!, name: "language"),
//            Category(image: UIImage(named: "embedded")!, name: "embedded")
//        ]
//        presenter?.didRetrieveCategories(categoryList)
        remoteDatamanager?.retrievePostList()
    }
}

extension StudyCategoryInteractor: StudyCategoryRemoteDataManagerOutputProtocol {
    func onCategoriesRetrieved(result: BaseResponse<[String]>) {
        var categoryList: [Category] = []
        
        if result.result {
            if let categories = result.data {
                for category in categories {
                    
                    /// Static Image
                    let image = "\(API.BASE_URL)images/category/\(category).png"
                    let name = category
                    
                    categoryList.append(Category(image: image, name: name))
                }
                presenter?.didRetrieveCategories(categoryList)
            }
        }
    }
    
    func onError() {
        
    }
}
