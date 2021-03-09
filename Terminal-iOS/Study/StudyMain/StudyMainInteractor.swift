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
        do {
            if let category = try localDataManager?.getCategory() {
                //여러가지 비지니스 로직을 거친 뒤
                presenter?.didSearchCategory(category: category)
            }
        } catch {
            //에러가 난 부분(하지만 가져오는데는 성공했지만 비어있는 경우도 분기해주어야함)
            presenter?.didSearchCategory(category: "")
        }
    }
}
