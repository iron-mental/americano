//
//  ViewController.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/08/31.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class ViewController: UITabBarController {
    let studyViewController = StudyCategoryView()
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
            studyViewController.tabBarItem = tabBarItems[.study]
            myStudyViewController.tabBarItem = tabBarItems[.mystudy]
            setViewController.tabBarItem = tabBarItems[.set]
            
            self.viewControllers = [
                UINavigationController(rootViewController: studyViewController),
                UINavigationController(rootViewController: myStudyViewController),
                UINavigationController(rootViewController: setViewController)
            ]
    }

}
