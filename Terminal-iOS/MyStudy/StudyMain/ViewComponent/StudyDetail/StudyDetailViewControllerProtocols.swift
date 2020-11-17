//
//  StudyDetailViewControllerProtocols.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/11/16.
//  Copyright © 2020 정재인. All rights reserved.
//

import Foundation
struct TempStudyDetailStruct {
    var title : String
}
protocol StudyDetailViewControllerViewProtocol {
    var studyInfo: [TempStudyDetailStruct] { get set }
}

protocol StudyDetailViewControllerInteractorProtocol {
    
}

protocol StudyDetailViewControllerPresenterProtocol {
    
}

protocol StudyDetailViewControllerRemoteDataManagerProtocol {
    
}

protocol StudyDetailViewControllerLocalDataManagerProtocol {
    
}

protocol StudyDetailViewControllerWireFrameProtocol {
    static func createMyStudyDetailViewModul() -> UIViewController
}
