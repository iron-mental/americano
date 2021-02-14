//
//  MyStudyMainInteractor.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/10/11.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class MyStudyMainInteractor: MyStudyMainInteractorProtocol {
    var presenter: MyStudyMainPresenterProtocol?
    var remoteManager: MyStudyMainRemoteDataManagerProtocol?
    var localManager: MyStudyMainLocalDataManagerProtocol?
    
    func getMyStudyList() {
        remoteManager?.getMyStudyList(completion: { response in
            switch response.result {
            case true:
                self.presenter?.MyStudyListResult(result: response.result, itemList: response.data)
            case false:
                self.presenter?.MyStudyListResult(result: response.result, itemList: response.data)
            }
        })
    }
}
