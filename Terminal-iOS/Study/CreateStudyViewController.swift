//
//  CreateStudyViewController.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/08.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class CreateStudyViewController: UIViewController {
    var tempTextLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
    
    func attribute() {
        view.do {
            $0.backgroundColor = .green
        }
        tempTextLabel.do {
            $0.frame = CGRect(x: 0, y: 0, width: 0, height: 35)
            $0.backgroundColor = .red
        }
    }
    
    func layout() {
        view.addSubview(tempTextLabel)
        i
        tempTextLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
            $0.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        }
    }
}
