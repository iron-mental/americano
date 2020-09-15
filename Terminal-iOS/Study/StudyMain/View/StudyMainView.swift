//
//  StudyViewController.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/08/31.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import Then

class StudyMainView: UIViewController {
    var presenter: StudyMainPresenterProtocol?
    
    var tempView = UIImageView()
    var titleView = UILabel()
    
    override func viewDidLoad() {
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
    }
    
    func attribute() {
        
        view.do {
            $0.backgroundColor = UIColor(named: "backGround")
        }
        
        navigationController?.navigationBar.do {
            $0.tintColor = .white
            $0.barTintColor = UIColor(named: "backGround")
            $0.isTranslucent = false
        }
        
        tempView.do {
            $0.image = #imageLiteral(resourceName: "categoryimage")
            $0.contentMode = .scaleAspectFit
        }
        
        titleView.do {
            $0.text = "스터디"
            $0.textColor = .white
        }
        
        navigationItem.do {
            $0.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(goToSelectCategory))
            $0.titleView = titleView
        }
        
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
        },completion: { _ in
            self.presenter?.goToCreateStudy()
            UIView.animate(withDuration: 0, animations: {
                self.tempView.transform = self.tempView.transform.translatedBy(x: 0, y: -60)
            })
        })
    }
}

extension StudyMainView: StudyMainViewProtocol {
    
    func showCategory(category: String) {
        attribute()
        layout()
        print("가져온부분 : \(category)")
    }
    
    func showLoading() {
        print("showLoading")
    }
    
    func hideLoading() {
        print("hideLoading")
    }
    
}

