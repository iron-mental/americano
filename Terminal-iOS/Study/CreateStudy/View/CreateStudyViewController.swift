//
//  CreateStudyViewController.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/08.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class CreateStudyViewController: UIViewController {
    let titleView = UILabel()
    var selectedCategory: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
        dump(selectedCategory)
    }
    
    func attribute() {
        view.do {
            $0.backgroundColor = .green
        }
        titleView.do {
            $0.text = "스터디 만들기"
            $0.textColor = .white
        }
        navigationItem.titleView = titleView
    }
    
    func layout() {
        view.addSubview(titleView)
    }
    @objc func backToPreView() {
    }
}
