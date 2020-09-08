//
//  StudyViewController.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/08/31.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class StudyViewController: UIViewController {
    
    var tempView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        attribute()
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        navigationItem.title = ""
    }
    func attribute() {
        tempView.do {
            $0.image = #imageLiteral(resourceName: "categoryimage")
            $0.contentMode = .scaleAspectFit
        }
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(goToSelectCategory))
    }
    func layout() {
        view.addSubview(tempView)
        
        tempView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: -60).isActive = true
            $0.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -30).isActive = true
            
        }
    }
    
    @objc func goToSelectCategory() {
        UIView.animate(withDuration: 0.2, delay: 0, options: .transitionCurlUp, animations: {
            self.tempView.transform = self.tempView.transform.translatedBy(x: 0, y: 60)
        },completion: {_ in
            let selectCategoryViewController = SelectCategoryViewController()
            self.navigationController?.pushViewController(selectCategoryViewController, animated: false)
            UIView.animate(withDuration: 0, animations: {
                self.tempView.transform = self.tempView.transform.translatedBy(x: 0, y: -60)
            })
        })
        
    }
}
