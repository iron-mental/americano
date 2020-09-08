//
//  StudyViewController.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/08/31.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class StudyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        attribute()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIView.setAnimationsEnabled(false)
        navigationItem.title = ""
    }
    
    func attribute() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(goToSelectCategory))
    }
    
    @objc func goToSelectCategory() {
        let selectCategoryViewController = SelectCategoryViewController()
        navigationController?.pushViewController(selectCategoryViewController, animated: true)
    }
}
