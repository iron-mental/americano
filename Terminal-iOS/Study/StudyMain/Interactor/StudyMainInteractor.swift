//
//  StudyMainInteractor.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/14.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class StudyMainInteractor: StudyMainInteractorProtocol {
    var presenter: StudyMainPresenterProtocol?
    var localDataManager: StudyMainLocalDataManagerProtocol?
    var remoteDataManager: StudyMainRemoteDataManagerProtocol?
    
    func searchCategory() {
        localDataManager?.getCategory()
    }
}
