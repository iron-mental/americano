//
//  CreateStudyProtocols.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/15.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

protocol CreateStudyViewProtocols: class {
    var presenter: CreateStudyPresenterProtocols? { get set }
    
    //PRESENTER -> VIEW
    func setView()
    func getBackgroundImage()
    func setBackgroundImage()
}

protocol CreateStudyInteractorProtocols: class {
    var presenter: CreateStudyPresenterProtocols? { get set }
    
}

protocol CreateStudyPresenterProtocols: class {
    var view: CreateStudyViewProtocols? { get set }
    var interactor: CreateStudyInteractorProtocols? { get set }
    var wireFrame: CreateStudyWireFrameProtocols? { get set }
    
    //VIEW -> PRESENTER
    func viewDidLoad()
    func notionInputFinish()
    func everNoteInputFinish()
    func URLInputFinish()
    func clickAddressInput()
    func didCompleteButtonClick()
}

protocol CreateStudyRemoteDataManagerProtocols: class {
    
}

protocol CreateStudyLocalDataManagerProtocols: class {
    
}

protocol CreateStudyWireFrameProtocols: class {
    static func createStudyViewModul(category: String) -> UIViewController
    
}
