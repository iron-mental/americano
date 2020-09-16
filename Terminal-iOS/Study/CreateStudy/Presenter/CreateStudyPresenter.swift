//
//  CreateStudyPresenter.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/15.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class CreateStudyPresenter: CreateStudyPresenterProtocols {
    var view: CreateStudyViewProtocols?
    var interactor: CreateStudyInteractorProtocols?
    var wireFrame: CreateStudyWireFrameProtocols?
    
    func viewDidLoad() {
        print("이거 안넘어와?")
        view?.setView()
        
    }
    
    func notionInputFinish() {
        print("notion")
    }
    
    func everNoteInputFinish() {
        print("everNote")
    }
    
    func URLInputFinish() {
        print("URL")
    }
    
    func clickAddressInput() {
        print("address")
    }
    
    func didCompleteButtonClick() {
        print("complete")
    }
    

}
