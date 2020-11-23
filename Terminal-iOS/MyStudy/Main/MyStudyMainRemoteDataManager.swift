//
//  MyStudyMainRemoteDataManager.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/10/11.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class MyStudyMainRemoteDataManager: MyStudyMainRemoteDataManagerProtocol {
    
    var interactor: MyStudyMainInteractorProtocol?
    
    func getMyStudyList(completion: @escaping (_: Bool, _: [MyStudy]?) -> ()) {
        TerminalAPI.getMyStudyList { (result, itemList) in
            switch result {
            case true:
                print(itemList)
                completion(result, itemList)
                break
            case false:
                completion(result, nil)
                break
            }
           
        }
    }
}
