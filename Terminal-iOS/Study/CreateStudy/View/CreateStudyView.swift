//
//  CreateStudyView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/15.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class CreateStudyView: UIViewController {
    var presenter: CreateStudyPresenterProtocols?
    var selectedCategory: String?
    
    override func viewDidLoad() {
        presenter?.viewDidLoad()
    }
    func attribute() {
        view.do {
            $0.backgroundColor = .green
        }
    }
    
    func layout() {
    }
}

extension CreateStudyView: CreateStudyViewProtocols {
    func setView() {
        attribute()
        layout()
    }
    
    func getBackgroundImage() {
        print("getBackgroundImage")
    }
    
    func setBackgroundImage() {
        print("setVackgroundImage")
    }
}
