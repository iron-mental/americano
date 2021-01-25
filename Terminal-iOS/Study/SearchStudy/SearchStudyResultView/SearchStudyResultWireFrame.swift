//
//  SearchStudyResultWireFrame.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/04.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

class SearchStudyResultWireFrame: SearchStudyResultWireFrameProtocol {
    
    static func createSearchStudyResultModule() -> UIViewController{
        let view = SearchStudyResultView()
        let interactor = SearchStudyResultInteractor()
        let presenter = SearchStudyResultPresenter()
        let remoteDataManager = SearchStudyResultRemoteDataManager()
        let localDataManager = SearchStudyResultLocalDataManager()
        let wireFrame = SearchStudyResultWireFrame()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.wireFrame = wireFrame
        interactor.presenter = presenter
        interactor.remoteDataManager = remoteDataManager
        interactor.localDataManager = localDataManager
        remoteDataManager.interactor = interactor
        
        return view
    }
    func presentStudyDetailScreen(from view: SearchStudyResultViewProtocol, keyValue: Int, state: Bool) {
        //state 값 이렇게 줄게 아니라 athority 받아와서 분기후에 정확하게 그에맞는걸로 해야댐
        
        if state {
            let myStudyDetailViewController = MyStudyDetailWireFrame.createMyStudyDetailModule(studyID: keyValue)
            if let sourceView = view as? UIViewController {
                sourceView.navigationController?.pushViewController(myStudyDetailViewController, animated: true)
            }
        } else {
            let studyState: StudyDetailViewState = state ? .member : .none
            let studyDetailViewController = StudyDetailWireFrame.createStudyDetail(parent: nil, studyID: keyValue, state: studyState)
            if let sourceView = view as? UIViewController {
                sourceView.navigationController?.pushViewController(studyDetailViewController, animated: true)
            }
        }
    }
}
