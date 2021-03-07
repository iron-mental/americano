//
//  ViewController.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/08/31.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class ViewController: UITabBarController {
    enum Tab: Int {
        case study
        case mystudy
        case set
    }
    
    let signUpState: Bool?
    var targetStudyID: Int? { didSet { print("Test") } }
    var targetAlarmType: AlarmType?
    var studyViewController = StudyCategoryWireFrame.createStudyCategory()
    var myStudyViewController = MyStudyMainWireFrame.createMyStudyMainViewModul()
    var setViewController = SetWireFrame.setCreateModule()
    static var tabBarBeforeIndex = 1
    static var tabBarSelectedIndex = 0
    lazy var tabBarItems: [Tab: UITabBarItem] = [
        .study: UITabBarItem(
            title: "스터디",
            image: UIImage(systemName: "book"),
            selectedImage: UIImage(systemName: "book")?
                .withConfiguration(UIImage.SymbolConfiguration(weight: .bold))
        ),
        .mystudy: UITabBarItem(
            title: "내 스터디",
            image: UIImage(systemName: "person.3"),
            selectedImage: UIImage(systemName: "person.3")?
                .withConfiguration(UIImage.SymbolConfiguration(weight: .bold))
        ),
        .set: UITabBarItem(
            title: "설정",
            image: UIImage(systemName: "gearshape"),
            selectedImage: UIImage(systemName: "gearshape")?
                .withConfiguration(UIImage.SymbolConfiguration(weight: .bold))
        )
    ]
    
    init(signUpState: Bool? = nil) {
        self.signUpState = signUpState
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
    }
    
    func attribute() {
        self.do {
            $0.delegate = self
        }
        self.tabBar.do {
            $0.tintColor = .white
            $0.barTintColor = UIColor.appColor(.testColor)
            $0.isTranslucent = false
            $0.unselectedItemTintColor = .systemGray2
            $0.standardAppearance.backgroundColor = .white
        }
        myStudyViewController = MyStudyMainWireFrame.createMyStudyMainViewModul(studyID: targetStudyID, alarmType: targetAlarmType)

        self.studyViewController.tabBarItem = tabBarItems[.study]
        self.studyViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        
        self.myStudyViewController.tabBarItem = tabBarItems[.mystudy]
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
        
        if let state = self.signUpState, state == true {
            self.selectedIndex = 0
        } else {
            self.selectedIndex = 1
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
            destination.transform = CGAffineTransform(translationX: 15, y: 0)
        } else {
            destination.transform = CGAffineTransform(translationX: -15, y: 0)
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
