//
//  SearchLocationProtocols.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/10/29.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

protocol SearchLocationViewProtocol: class {
    var presenter: SearchLocationPresenterProtocol? { get set }
    var parentView: UIViewController? { get set }
    //PRESENTER -> VIEW
    func dismiss()
    func showSearchResult(list: [StudyDetailLocationPost])
}

protocol SearchLocationPresenterProtocol: class {
    var view: SearchLocationViewProtocol? { get set }
    var interactor: SearchLocationInteractorProtocol? { get set }
    var wireFrame: SearchLocationWireFrameProtocol? { get set }
    
    //VIEW -> PRESENTER
    //추후에 index가 아닌 remoteDataManager로 부터 받아온 정보중 좌표값을 넘겨주어야 할듯 하네요
    func didSelectedItem(item: StudyDetailLocationPost, view: UIViewController, parentView: UIViewController)
    func didClickedSearchButton(text: String)
    //INTERACTOR -> PRESENTER
    func searchResult(list: [StudyDetailLocationPost])
}

protocol SearchLocationInteractorProtocol: class {
    var presenter: SearchLocationPresenterProtocol? { get set }
    var remoteDataManager: SearchLocationRemoteDataManagerProtocol? { get set }
    
    //PRESENTER -> INTERACTOR
    func searchKeyWord(text: String)
}

protocol SearchLocationRemoteDataManagerProtocol: class {
    func getSearchResult(text: String, completionHandler: @escaping (_: Bool, _ list: [StudyDetailLocationPost]) -> Void)
}

protocol SearchLocationWireFrameProtocol: class {
    var presenter: SearchLocationPresenterProtocol? { get set }
    static func searchLocationViewModul(parentView: UIViewController) -> UIViewController
    
    //PRESENTER -> WIREFRAME
    func goToSelectLocationView(item: StudyDetailLocationPost, view: UIViewController, parentView: UIViewController)
}
