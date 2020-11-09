//
//  ProfileModifyView.swift
//  Terminal-iOS
//
//  Created by once on 2020/11/09.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class ProfileModifyView: UIViewController {
    lazy var profileImage = UIImageView()
    lazy var nameModify = UITextField()
    lazy var descripModify = UITextView()
    lazy var careerLabel = UILabel()
    lazy var careerTitleModify = UITextField()
    lazy var careerDescriptModify = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
        textViewDidChange(descripModify)
        textViewDidChange(careerDescriptModify)
    }
    
    func attribute() {
        profileImage.do {
            $0.backgroundColor = UIColor.appColor(.terminalBackground)
            $0.image = #imageLiteral(resourceName: "leehi")
            $0.contentMode = .scaleAspectFill
            $0.frame.size.width = Terminal.convertHeigt(value: 100)
            $0.frame.size.height = Terminal.convertHeigt(value: 100)
            $0.layer.cornerRadius = $0.frame.width / 2
            $0.clipsToBounds = true
        }
        nameModify.do {
            $0.font = UIFont(name: nameModify.font!.fontName, size: 20)
            $0.dynamicFont(fontSize: 20, weight: .semibold)
        }
        descripModify.do {
            $0.backgroundColor = .red
            $0.delegate = self
            $0.dynamicFont(size: 16, weight: .regular)
            $0.textColor = .white
            $0.sizeToFit()
            $0.textContainer.lineFragmentPadding = 0
            $0.textContainerInset = .zero
        }
        careerLabel.do {
            $0.text = "경력"
            $0.textColor = .white
        }
        careerTitleModify.do {
            $0.text = "OO대학교 4학년 재학중"
            $0.textColor = .white
            $0.dynamicFont(fontSize: 16, weight: .bold)
            $0.textAlignment = .left
            $0.backgroundColor = .blue
        }
        careerDescriptModify.do {
            $0.text = "경력에 대한 짧은 소개가 들어가는 중입니다. 경력에 대한 짧은 소개가 들어가는 중입니다. 경력에 대한 짧은 소개가 들어가는 중입니다.경력에 대한 짧은 소개가 들어가는 중입니다. 경력에 대한 짧은 소개가 들어가는 중입니다. 경력에 대한 짧은 소개가 들어가는 중입니다."
            $0.textColor = UIColor.appColor(.profileTextColor)
            $0.dynamicFont(size: 14, weight: .regular)
            $0.delegate = self
            $0.sizeToFit()
            $0.backgroundColor = .red
            $0.textContainer.lineFragmentPadding = 0
            $0.textContainerInset = .zero
        }
    }
    
    func layout() {
        view.addSubview(profileImage)
        view.addSubview(nameModify)
        view.addSubview(descripModify)
        view.addSubview(careerLabel)
        view.addSubview(careerTitleModify)
        view.addSubview(careerDescriptModify)
        
        profileImage.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
            $0.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertHeigt(value: 100)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeigt(value: 100)).isActive = true
        }
        nameModify.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 20).isActive = true
            $0.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        }
        descripModify.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: nameModify.bottomAnchor, constant: 7).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
            $0.heightAnchor.constraint(lessThanOrEqualToConstant: 10).isActive = true
        }
        careerLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: descripModify.bottomAnchor, constant: 18).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
        }
        careerTitleModify.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: careerLabel.bottomAnchor, constant: 4).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
        }
        careerDescriptModify.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: careerTitleModify.bottomAnchor, constant: 4).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25).isActive = true
            $0.heightAnchor.constraint(lessThanOrEqualToConstant: 10).isActive = true
        }
    }
}


extension ProfileModifyView: UITextViewDelegate {
    
    //MARK: TextView Dynamic Height
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: view.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        textView.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
    }
}
