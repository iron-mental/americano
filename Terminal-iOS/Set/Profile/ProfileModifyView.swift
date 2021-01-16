//
//  ProfileModifyView.swift
//  Terminal-iOS
//
//  Created by once on 2020/11/09.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import Kingfisher
import SwiftKeychainWrapper

class ProfileModifyView: UIViewController {
    var presenter: ProfileModifyPresenterProtocol?
    var profile: Profile?
    let picker = UIImagePickerController()

    let projectAddButton = UIButton()
    
    lazy var profileImage = UIImageView()
    lazy var nameLabel = UILabel()
    lazy var introductionLabel = UILabel()
    lazy var name = UITextField()
    lazy var introduction = UITextView()
    lazy var completeButton = UIButton()
    
    // MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        attribute()
        layout()
        textViewDidChange(introduction)
    }
    
    // MARK: Set Attribute
    func attribute() {
        self.view.backgroundColor = .appColor(.terminalBackground)
        self.picker.do {
            $0.delegate = self
        }

        self.profileImage.do {
            $0.image = self.profile?.profileImage
            let profileTapGesture = UITapGestureRecognizer(target: self, action: #selector(didImageViewClicked))
            $0.addGestureRecognizer(profileTapGesture)
            $0.backgroundColor = .appColor(.terminalBackground)
            $0.contentMode = .scaleAspectFill
            $0.frame.size.width = Terminal.convertHeigt(value: 100)
            $0.frame.size.height = Terminal.convertHeigt(value: 100)
            $0.layer.cornerRadius = $0.frame.width / 2
            $0.clipsToBounds = true
            $0.isUserInteractionEnabled = true
            $0.backgroundColor = .blue
        }
        self.nameLabel.do {
            $0.text = "이름"
            $0.font = UIFont(name: "NotoSansKR-Medium", size: 12)
        }
        self.name.do {
            $0.text = self.profile?.nickname
            $0.placeholder = "닉네임"
            $0.dynamicFont(fontSize: 16, weight: .regular)
            $0.layer.cornerRadius = 10
            $0.backgroundColor = UIColor.appColor(.cellBackground)
            $0.addLeftPadding()
        }
        self.introductionLabel.do {
            $0.text = "자기소개"
            $0.font = UIFont(name: "NotoSansKR-Medium", size: 12)
        }
        self.introduction.do {
            $0.backgroundColor = .darkGray
            $0.text = self.profile?.introduction
            $0.delegate = self
            $0.dynamicFont(size: 16, weight: .regular)
            $0.textColor = .white
            $0.sizeToFit()
            $0.textContainer.lineFragmentPadding = 0
            $0.textContainerInset = .zero
            $0.layer.cornerRadius = 10
            $0.backgroundColor = UIColor.appColor(.cellBackground)
            $0.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 6)
        }
        
        self.completeButton.do {
            $0.backgroundColor = .appColor(.mainColor)
            $0.setTitle("수정완료", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.layer.cornerRadius = 10
            $0.addTarget(self, action: #selector(completeModify), for: .touchUpInside)
        }
    }
    
    // MARK: Set Layout
    
    func layout() {
        [self.profileImage, self.nameLabel, self.name, self.introductionLabel, self.introduction, self.completeButton]
            .forEach { self.view.addSubview($0) }
        
        self.profileImage.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
            $0.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertHeigt(value: 100)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeigt(value: 100)).isActive = true
        }
        self.nameLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.profileImage.bottomAnchor, constant: 20).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 25).isActive = true
        }
        self.name.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 5).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 25).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -25).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 40).isActive = true
        }
        
        self.introductionLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.name.bottomAnchor, constant: 20).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 25).isActive = true
        }
        
        self.introduction.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.introductionLabel.bottomAnchor, constant: 5).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 25).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -25).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 50).isActive = true
        }
        
        self.completeButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.introduction.bottomAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 25).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -25).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 60).isActive = true
        }
    }
    
    @objc func backgroundTap() {
        self.view.endEditing(true)
    }
    
    @objc func didImageViewClicked() {
        let alert =  UIAlertController(title: "대표 사진 설정", message: nil, preferredStyle: .actionSheet)
        let library =  UIAlertAction(title: "사진앨범", style: .default) { (action) in self.openLibrary() }
        let camera =  UIAlertAction(title: "카메라", style: .default) { (action) in self.openCamera() }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(library)
        alert.addAction(camera)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    func openLibrary() {
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    func openCamera() {
        picker.sourceType = .camera
        present(picker, animated: true, completion: nil)
    }
    
    // MARK: - 프로필 수정 완료 버튼
    
    @objc func completeModify() {
        var nickname: String = ""
        
        // 현재 내가 가지고있는 닉네임과 완료를 누르기전 변경된 닉네임 비교
        let currentNickname = (self.profile?.nickname)!
        let changedNickname = self.name.text!
        
        // 닉네임이 같으면 변경 안했으므로 공백, 다르면 변경된 값 적용
        if currentNickname != changedNickname {
            nickname = changedNickname
        }
        
        let introduction    = self.introduction.text!
        let image           = profileImage.image!
        
        let profile         = Profile(profileImage: image, nickname: nickname, introduction: introduction)
        
        presenter?.completeImageModify(image: image)
        presenter?.completeModify(profile: profile)
    }

}

extension ProfileModifyView: ProfileModifyViewProtocol {
    func modifyResultHandle(result: Bool, message: String) {
        if result {
            print("수정 여부:", result)
            print("메시지 : ", message)
            let parent = self.navigationController?.viewControllers[1] as? ProfileDetailView
            self.navigationController?.popViewController(animated: true, completion: {
                parent?.showToast(controller: parent!, message: "프로필 수정 완료", seconds: 1)
                parent?.presenter?.viewDidLoad()
            })
            
            let rootParent = self.navigationController?.viewControllers[0] as? SetView
            rootParent?.presenter?.viewDidLoad()
        }
    }
}

// MARK: 이미지 픽커

extension ProfileModifyView:  UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            self.profileImage.image = image
        }
        dismiss(animated: true, completion: nil)
    }
}

// MARK: 텍스트 필드

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

extension ProfileModifyView: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView){
        self.view.endEditing(true)
    }
}
