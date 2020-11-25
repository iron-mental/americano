//
//  MyStudyMainWireFrame.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/10/11.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class MyStudyMainWireFrame: MyStudyMainWireFrameProtocol {
    var presenter: MyStudyMainPresenter?

    static func createMyStudyMainViewModul() -> UIViewController {
        let view = MyStudyMainView()
        let presenter = MyStudyMainPresenter()
        let interactor = MyStudyMainInteractor()
        let remoteDataManager = MyStudyMainRemoteDataManager()
        let localDataManager = MyStudyMainLocalDataManager()
        let wireFrame = MyStudyMainWireFrame()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        interactor.remoteManager = remoteDataManager
        interactor.localManager = localDataManager
        
        return view
        
    }
    
    func goToAalrmView(view: UIViewController) {
        
    }
    
    func goToStudyDetailView(view: UIViewController, selectedStudy: MyStudy) {
        //wireframe 작업 해서 가야됨 스터디 정보 담아서
//        let studyDetailView = MyStudyDetailView()
        let myStudyDetailView =  MyStudyDetailWireFrame.createMyStudyDetailModule(studyID: selectedStudy.id)
//        let studyDetailView = StudyDetailWireFrame.createStudyDetail(keyValue: selectedStudy.id)
        view.navigationController?.pushViewController(myStudyDetailView, animated: true)
    }
}
