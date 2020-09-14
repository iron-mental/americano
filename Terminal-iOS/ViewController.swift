//
//  ViewController.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/08/31.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class ViewController: UITabBarController {
    
    let studyViewController = StudyViewController()
    let myStudyViewController = MyStudyViewController()
    let setViewController = SetViewController()
    
    enum Tab: Int {
        case study
        case mystudy
        case set
    }
    
    let tabBarItems: [Tab: UITabBarItem] = [
        .study: UITabBarItem(
            title: nil,
            image: #imageLiteral(resourceName: "study"),
            selectedImage: #imageLiteral(resourceName: "study_clicked")
        ),
        .mystudy: UITabBarItem(
            title: nil,
            image: #imageLiteral(resourceName: "mystudy"),
            selectedImage: #imageLiteral(resourceName: "mystudy_clicked")
        ),
        .set: UITabBarItem(
            title: nil,
            image: #imageLiteral(resourceName: "set"),
            selectedImage: #imageLiteral(resourceName: "set_clicked")
        )
        
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        
    }
    
    func attribute() {
        tabBar.do {
            $0.tintColor = UIColor(named: "key")
            $0.barTintColor = UIColor(named: "backGround")
            $0.isTranslucent = false
            $0.unselectedItemTintColor = .white
        }
        
        
        studyViewController.tabBarItem = tabBarItems[.study]
        studyViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        
        myStudyViewController.tabBarItem = tabBarItems[.mystudy]
        myStudyViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        
        setViewController.tabBarItem = tabBarItems[.set]
        setViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        
        self.viewControllers = [
            UINavigationController(rootViewController: studyViewController),
            UINavigationController(rootViewController: myStudyViewController),
            UINavigationController(rootViewController: setViewController)
        ]
    }
}

