//
//  ProfileModifyView.swift
//  Terminal-iOS
//
//  Created by once on 2020/11/09.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class ProfileModifyView: UIViewController {
    lazy var scrollView = UIScrollView()
    lazy var backgroundView = UIView()
    lazy var profileImage = UIImageView()
    lazy var nameModify = UITextField()
    lazy var descripModify = UITextView()
    lazy var careerLabel = UILabel()
    lazy var careerTitleModify = UITextField()
    lazy var careerDescriptModify = UITextView()
    lazy var projectLabel = UILabel()
    lazy var projectTitleModify = UITextField()
    lazy var projectDescriptModify = UITextView()
    lazy var snsModify = SNSModifyView()
    lazy var emailModify = EmailModifyView()
    lazy var locationModify = LocationModifyView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
        textViewDidChange(descripModify)
        textViewDidChange(careerDescriptModify)
        textViewDidChange(projectDescriptModify)
    }
    
    func attribute() {
        scrollView.do {
            $0.bounces = false
        }
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
            $0.delegate = self
        }
        careerDescriptModify.do {
            $0.text = "경력에 대한 짧은 소개가 들어가는 중입니다. 경력에 대한 짧은 소개가 들어가는 중입니다. 경력에 대한 짧은 소개가 들어가는 중입니다.경력에 대한 짧은 소개가 들어가는 중입니다. 경력에 대한 짧은 소개가 들어가는 중입니다. 경력에 대한 짧은 소개가 들어가는 중입니다.MANNA는 어떠 어떠한 프로젝트이며 이러 이러 합니다. 저러 저러한 사람들이 쉽게 이러 이러하고 요로요로 어쩌고 저쩌고 하여 만들어진 프로젝트입니다. 이러이러한 걸 맡았고 어쩌고 저쩌고 하였습니다. 아래 github 링크에서 자세한 내용 확인하실 수 있습니다. 이하이 이쁩니다. 인정MANNA는 어떠 어떠한 프로젝트이며 이러 이러 합니다. 저러 저러한 사람들이 쉽게 이러 이러하고 요로요로 어쩌고 저쩌고 하여 만들어진 프로젝트입니다. 이러이러한 걸 맡았고 어쩌고 저쩌고 하였습니다. 아래 github 링크에서 자세한 내용 확인하실 수 있습니다. 이하이 이쁩니다. 인정"
            $0.textColor = UIColor.appColor(.profileTextColor)
            $0.dynamicFont(size: 14, weight: .regular)
            $0.delegate = self
            $0.sizeToFit()
            $0.textContainer.lineFragmentPadding = 0
            $0.textContainerInset = .zero
            $0.layer.masksToBounds = true
            $0.isScrollEnabled = false
        }
        projectLabel.do {
            $0.text = "프로젝트"
            $0.textColor = .white
        }
        projectTitleModify.do {
            $0.text = "Terminal"
            $0.textColor = .white
            $0.dynamicFont(fontSize: 16, weight: .bold)
            $0.textAlignment = .left
            $0.delegate = self
        }
        projectDescriptModify.do {
            $0.text = "MANNA는 어떠 어떠한 프로젝트이며 이러 이러 합니다. 저러 저러한 사람들이 쉽게 이러 이러하고 요로요로 어쩌고 저쩌고 하여 만들어진 프로젝트입니다. 이러이러한 걸 맡았고 어쩌고 저쩌고 하였습니다. 아래 github 링크에서 자세한 내용 확인하실 수 있습니다. 이하이 이쁩니다. 인정MANNA는 어떠 어떠한 프로젝트이며 이러 이러 합니다. 저러 저러한 사람들이 쉽게 이러 이러하고 요로요로 어쩌고 저쩌고 하여 만들어진 프로젝트입니다. 이러이러한 걸 맡았고 어쩌고 저쩌고 하였습니다. 아래 github 링크에서 자세한 내용 확인하실 수 있습니다. 이하이 이쁩니다. 인정MANNA는 어떠 어떠한 프로젝트이며 이러 이러 합니다. 저러 저러한 사람들이 쉽게 이러 이러하고 요로요로 어쩌고 저쩌고 하여 만들어진 프로젝트입니다. 이러이러한 걸 맡았고 어쩌고 저쩌고 하였습니다. 아래 github 링크에서 자세한 내용 확인하실 수 있습니다. 이하이 이쁩니다. 인정"
            $0.textColor = UIColor.appColor(.profileTextColor)
            $0.dynamicFont(size: 14, weight: .regular)
            $0.delegate = self
            $0.sizeToFit()
            $0.textContainer.lineFragmentPadding = 0
            $0.textContainerInset = .zero
            $0.layer.masksToBounds = true
            $0.isScrollEnabled = false
        }
    }
    
    func layout() {
        view.addSubview(scrollView)
        scrollView.addSubview(backgroundView)
        [profileImage, nameModify, descripModify, careerLabel, careerTitleModify, careerDescriptModify, projectLabel, projectTitleModify, projectDescriptModify, snsModify, emailModify, locationModify].forEach { backgroundView.addSubview($0) }

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
            $0.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        }
        profileImage.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 20).isActive = true
            $0.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertHeigt(value: 100)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeigt(value: 100)).isActive = true
        }
        nameModify.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 20).isActive = true
            $0.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
        }
        descripModify.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: nameModify.bottomAnchor, constant: 7).isActive = true
            $0.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 25).isActive = true
            $0.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -25).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 400).isActive = true
        }
        careerLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: descripModify.bottomAnchor, constant: 18).isActive = true
            $0.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 25).isActive = true
            $0.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -25).isActive = true
        }
        careerTitleModify.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: careerLabel.bottomAnchor, constant: 4).isActive = true
            $0.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 25).isActive = true
            $0.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -25).isActive = true
        }
        careerDescriptModify.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: careerTitleModify.bottomAnchor, constant: 4).isActive = true
            $0.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 25).isActive = true
            $0.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -25).isActive = true
            $0.heightAnchor.constraint(lessThanOrEqualToConstant: 400).isActive = true
        }
        projectLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: careerDescriptModify.bottomAnchor, constant: 19).isActive = true
            $0.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 25).isActive = true
            $0.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -25).isActive = true
        }
        projectTitleModify.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: projectLabel.bottomAnchor, constant: 4).isActive = true
            $0.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 25).isActive = true
            $0.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -25).isActive = true
        }
        projectDescriptModify.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: projectTitleModify.bottomAnchor, constant: 4).isActive = true
            $0.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 25).isActive = true
            $0.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -25).isActive = true
            $0.heightAnchor.constraint(lessThanOrEqualToConstant: 400).isActive = true
        }
        snsModify.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: projectDescriptModify.bottomAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor).isActive = true
            $0.heightAnchor.constraint(equalTo: snsModify.heightAnchor).isActive = true
        }
        emailModify.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: snsModify.bottomAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor).isActive = true
            $0.heightAnchor.constraint(equalTo: emailModify.heightAnchor).isActive = true
        }
        locationModify.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: emailModify.bottomAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor).isActive = true
            $0.heightAnchor.constraint(equalTo: locationModify.heightAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -20).isActive = true
        }
    }
}

extension ProfileModifyView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
