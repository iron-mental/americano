//
//  StudyCategoryInteractor.swift
//  Terminal-iOS
//
//  Created by once on 2020/09/14.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class StudyCategoryInteractor: StudyCategoryInteractorInputProtocol {
    weak var presenter: StudyCategoryInteractorOutputProtocol?
    var localDatamanager: StudyCategoryLocalDataManagerInputProtocol?
    var remoteDatamanager: StudyCategoryRemoteDataManagerInputProtocol?
    
    func retrieveStudyCategory() {
        remoteDatamanager?.retrievePostList()
    }
}

extension StudyCategoryInteractor: StudyCategoryRemoteDataManagerOutputProtocol {
    func onCategoriesRetrieved(result: BaseResponse<[String]>) {
        var categoryList: [Category] = []
        switch result.result {
        case true:
            if let categories = result.data {
                for category in categories {
                    /// Static Image
                    let image = category != "etc" ?
                    "https://www.terminal-study.tk/images/category/\(category).png" :
                    ""
                    let name = category
                    categoryList.append(Category(image: image, name: name))
                    
                }
                presenter?.didRetrieveCategories(categoryList)
            }
        case false:
            guard let message = result.message else { return }
            presenter?.onError(message: message)
        }
    }
}
