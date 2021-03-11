//
//  SearchLocationInteractor.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/10/29.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

final class SearchLocationInteractor: SearchLocationInteractorProtocol {
    weak var presenter: SearchLocationPresenterProtocol?
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
    func sessionTaskError(message: String) {
        presenter?.sessionTaskError(message: message)
    }
}
