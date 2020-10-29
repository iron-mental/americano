//
//  StudyDetailView.swift
//  Terminal-iOS
//
//  Created by once on 2020/10/29.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class StudyDetailView: UIViewController {
    let state: [String] = ["공지사항", "스터디 정보", "채팅"]
    
    let background = UIView().then {
        $0.backgroundColor = .white
    }
    let first = UIView().then {
        $0.backgroundColor = .blue
    }
    let second = UIView().then {
        $0.backgroundColor = .yellow
    }
    let third = UIView().then {
        $0.backgroundColor = .brown
    }
    
    lazy var tabSege = UISegmentedControl(items: state)
    lazy var selectedUnderLine = UIView()
    lazy var scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
    
    func attribute() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        
        self.do {
            $0.view.backgroundColor = UIColor.appColor(.terminalBackground)
            $0.navigationController?.navigationBar.standardAppearance = appearance
        }
        tabSege.do {
            $0.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 14),
                                       .foregroundColor: UIColor.gray], for: .normal)
            $0.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 16),
                                       .foregroundColor: UIColor.white], for: .selected)
            $0.selectedSegmentIndex = 0
            $0.layer.cornerRadius = 0
            $0.backgroundColor = .clear
            $0.tintColor = UIColor.appColor(.terminalBackground)
            $0.clearBG()
            $0.selectedSegmentTintColor = .clear
            $0.addTarget(self, action: #selector(indexChanged(_:)), for: .valueChanged)
        }
        selectedUnderLine.do {
            $0.backgroundColor = .white
        }
        scrollView.do {
            $0.backgroundColor = .red
            $0.bounces = false
        }
    }
    
    func layout() {
        view.addSubview(tabSege)
        view.addSubview(selectedUnderLine)
        view.addSubview(scrollView)
        scrollView.addSubview(background)
        background.addSubview(first)
        background.addSubview(second)
        background.addSubview(third)
        
        tabSege.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeigt(value: 38)).isActive = true
        }
        selectedUnderLine.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.bottomAnchor.constraint(equalTo: tabSege.bottomAnchor).isActive = true
            $0.centerXAnchor.constraint(equalTo: tabSege.centerXAnchor, constant: -view.frame.width / 3).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 3).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 50).isActive = true
        }
        scrollView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: tabSege.bottomAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        }
        background.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
            $0.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 3).isActive = true
        }
        first.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: background.topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: background.leadingAnchor).isActive = true
            $0.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        }
        second.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: background.topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: first.trailingAnchor).isActive = true
            $0.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        }
        third.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: background.topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: second.trailingAnchor).isActive = true
            $0.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        }
    }
    
    @objc func indexChanged(_ sender: UISegmentedControl) {
        let selectedIndex = CGFloat(sender.selectedSegmentIndex)
        
        UIView.animate(withDuration: 0.5) {
            self.selectedUnderLine.center.x = self.view.frame.width / 6 * ((selectedIndex * 2) + 1)
        }
        
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
            self.selectedUnderLine.transform = CGAffineTransform(scaleX: 1.6, y: 1)
        } completion: { (finish) in
            UIView.animate(withDuration: 0.4, animations: {
                self.selectedUnderLine.transform = CGAffineTransform.identity
            })
        }
    }
}
