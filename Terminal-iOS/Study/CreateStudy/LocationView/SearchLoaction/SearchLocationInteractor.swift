//
//  SearchLocationInteractor.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/10/29.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class SearchLocationInteractor: SearchLocationInteractorProtocol {
    var presenter: SearchLocationPresenterProtocol?
    var remoteDataManager: SearchLocationRemoteDataManagerProtocol?
    
    func searchKeyWord(text: String) {
        remoteDataManager?.getSearchResultByKeyword(text: text, completionHandler: { [self] (result, list)in
            if result {
                presenter?.searchResult(list: list)
            } else {
                presenter?.searchResult(list: [])
            }
        })
    }
}
