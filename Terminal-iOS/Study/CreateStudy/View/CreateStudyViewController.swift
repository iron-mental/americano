//
//  CreateStudyViewController.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/08.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

protocol testDelegate {
    func setData(data: String)
}

class CreateStudyViewController: UIViewController {
    let titleView = UILabel()
    
    
    var delegate: testDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
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
