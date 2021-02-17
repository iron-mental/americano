//
//  ViewController.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/08/31.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class ViewController: UITabBarController {
    let studyViewController = StudyCategoryWireFrame.createStudyCategory()
    let myStudyViewController = MyStudyMainWireFrame.createMyStudyMainViewModul()
    let setViewController = SetWireFrame.setCreateModule()
    static var tabBarBeforeIndex = 1
    static var tabBarSelectedIndex = 0
    
    enum Tab: Int {
        case study
        case mystudy
        case set
    }
    
    lazy var tabBarItems: [Tab: UITabBarItem] = [
        .study: UITabBarItem(
            title: "",
            image: #imageLiteral(resourceName: "study"),
            selectedImage: #imageLiteral(resourceName: "study_clicked")
        ),
        .mystudy: UITabBarItem(
            title: "",
            image: #imageLiteral(resourceName: "mystudy"),
            selectedImage: #imageLiteral(resourceName: "mystudy_clicked")
        ),
        .set: UITabBarItem(
            title: "설정",
            image: #imageLiteral(resourceName: "set"),
            selectedImage: #imageLiteral(resourceName: "set_clicked")
        )
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
    }
    
    func attribute() {
        self.do {
            $0.delegate = self
        }
        self.tabBar.do {
            $0.tintColor = UIColor(named: "key")
            $0.barTintColor = UIColor.appColor(.testColor)
            $0.isTranslucent = false
            $0.unselectedItemTintColor = .white
            $0.standardAppearance.backgroundColor = .white
            
        }

        self.studyViewController.tabBarItem = tabBarItems[.study]
        self.studyViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        
        self.myStudyViewController.tabBarItem = tabBarItems[.mystudy]
        tabBarItems[.mystudy] = UITabBarItem(tabBarSystemItem: .contacts, tag: 1)
        self.myStudyViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        
        self.setViewController.tabBarItem = tabBarItems[.set]
        self.setViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        
        let studyNVC = UINavigationController(rootViewController: self.studyViewController)
        studyNVC.navigationBar.tintColor = .white
        studyNVC.navigationBar.prefersLargeTitles = true
        
        let myStudyNVC = UINavigationController(rootViewController: self.myStudyViewController)
        myStudyNVC.navigationBar.tintColor = .white
        myStudyNVC.navigationBar.prefersLargeTitles = true
        
        let setNVC = UINavigationController(rootViewController: self.setViewController)
        setNVC.navigationBar.tintColor = .white
        setNVC.navigationBar.prefersLargeTitles = true
        
        self.viewControllers = [
            studyNVC,
            myStudyNVC,
            setNVC
        ]
        self.selectedIndex = 1
        
    }
}
extension ViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        ViewController.tabBarBeforeIndex = tabBarController.selectedIndex
        return TabBarAnimatedTransitioning()
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        ViewController.tabBarSelectedIndex = tabBarController.selectedIndex
    }
}
final class TabBarAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let destination = transitionContext.view(forKey: UITransitionContextViewKey.to) else { return }
        destination.alpha = 0.0
        if ViewController.tabBarBeforeIndex < ViewController.tabBarSelectedIndex {
            destination.transform = CGAffineTransform(translationX: 20, y: 0)
        } else {
            destination.transform = CGAffineTransform(translationX: -20, y: 0)
        }
        transitionContext.containerView.addSubview(destination)

        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            destination.alpha = 1.0
            destination.transform = .identity
        }, completion: { transitionContext.completeTransition($0) })
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.2
    }

}
