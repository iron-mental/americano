//
//  ProfileModifyView.swift
//  Terminal-iOS
//
//  Created by once on 2020/10/06.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class ProfileModifyView: UIViewController {
    
    let scrollView = UIScrollView().then {
        $0.backgroundColor = .red
    }
    let backgroundView = UIView().then {
        $0.backgroundColor = .blue
    }
    let profileAreaView = UIView()
    let profileImage = UIImageView()
    let name = UILabel()
    let descript = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
    
    func attribute() {
        self.do {
            $0.title = "프로필"
            $0.view.backgroundColor = UIColor.appColor(.terminalBackground)
        }
        profileImage.do {
            $0.contentMode = .scaleAspectFill
            $0.frame.size.width = UIScreen.main.bounds.width * 0.266
            $0.frame.size.height = UIScreen.main.bounds.width * 0.266
            $0.image = #imageLiteral(resourceName: "leehi")
            $0.layer.cornerRadius = $0.frame.size.width/2
            $0.clipsToBounds = true
        }
        name.do {
            $0.text = "이하이"
            $0.textColor = .white
            $0.textAlignment = .center
            $0.font = $0.font.withSize(20)
        }
        descript.do {
            $0.text = "iOS를 공부하는 중입니다. 잘 부탁드립니다."
            $0.numberOfLines = 0
            $0.font = $0.font.withSize(16)
        }
    }
    
    func layout() {
        view.addSubview(scrollView)
        scrollView.addSubview(backgroundView)
        backgroundView.addSubview(profileImage)
        backgroundView.addSubview(name)
        backgroundView.addSubview(descript)
        
        scrollView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        }
        backgroundView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
            $0.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 1.3).isActive = true
        }

//        profileImage.do {
//            $0.translatesAutoresizingMaskIntoConstraints = false
//            $0.topAnchor.constraint(equalTo: frameView.topAnchor,
//                                    constant: UIScreen.main.bounds.height * 0.02).isActive = true
//            $0.centerXAnchor.constraint(equalTo: frameView.centerXAnchor).isActive = true
//            $0.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.266).isActive = true
//            $0.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.266).isActive = true
//        }
//        name.do {
//            $0.translatesAutoresizingMaskIntoConstraints = false
//            $0.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 20).isActive = true
//            $0.centerXAnchor.constraint(equalTo: frameView.centerXAnchor).isActive = true
//        }
//        descript.do {
//            $0.translatesAutoresizingMaskIntoConstraints = false
//            $0.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 10).isActive = true
//            $0.centerXAnchor.constraint(equalTo: frameView.centerXAnchor).isActive = true
//        }
    }
}
