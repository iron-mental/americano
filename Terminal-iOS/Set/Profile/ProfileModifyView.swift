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
    deinit { self.keyboardRemoveObserver() }
    
    // MARK: Init Property
    
    var presenter: ProfileModifyPresenterProtocol?
    var profile: Profile?
    let picker = UIImagePickerController()

    let imageModify = UIImageView()
    let profileImage = UIImageView()
    let nameLabel = UILabel()
    let introductionLabel = UILabel()
    let name = UITextField()
    let introduction = UITextView()
    let completeButton = UIButton()
    var accessoryCompleteButton = UIButton()
    
    var contentHeight: CGFloat = 0
    var keyboardDuartion: Double = 0
    var topAnchor: NSLayoutConstraint?
    var profileExistence: Bool = false
    
    // MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        attribute()
        layout()
        hideLoading()
        self.keyboardAddObserver(showSelector: #selector(keyboardWillShow),
                                 hideSelector: #selector(keyboardWillHide))
    }

    // MARK: Set Attribute
    
    func attribute() {
        self.do {
            $0.hideKeyboardWhenTappedAround()
            $0.view.backgroundColor = .appColor(.terminalBackground)
            $0.title = "프로필 수정"
            $0.navigationItem.largeTitleDisplayMode = .never
        }
        self.picker.do {
            $0.delegate = self
        }
        self.profileImage.do {
            if let image = self.profile?.profileImage {
                $0.image = image
                self.profileExistence = true
            } else {
                $0.image = UIImage(named: "defaultProfile")!
                self.profileExistence = false
            }
            
            let profileTapGesture = UITapGestureRecognizer(target: self,
                                                           action: #selector(didImageViewClicked))
            $0.addGestureRecognizer(profileTapGesture)
            $0.contentMode = .scaleAspectFill
            $0.frame.size.width = Terminal.convertHeight(value: 100)
            $0.frame.size.height = Terminal.convertHeight(value: 100)
            $0.layer.cornerRadius = $0.frame.width / 2
            $0.clipsToBounds = true
            $0.isUserInteractionEnabled = true
        }
        self.imageModify.do {
            $0.image = UIImage(systemName: "plus.circle.fill")?.withConfiguration(UIImage.SymbolConfiguration(weight: .light))
            $0.tintColor = .lightGray
            $0.backgroundColor = .appColor(.terminalBackground)
            $0.frame.size.width = Terminal.convertHeight(value: 25)
            $0.frame.size.height = Terminal.convertHeight(value: 25)
            $0.layer.cornerRadius = $0.frame.width / 2
            $0.layer.borderColor = UIColor.appColor(.terminalBackground).cgColor
            $0.layer.borderWidth = 3
            $0.clipsToBounds = true
        }
        self.nameLabel.do {
            $0.text = "이름"
            $0.font = UIFont(name: "NotoSansKR-Medium", size: 12)
        }
        self.name.do {
            $0.text = self.profile?.nickname
            $0.placeholder = "닉네임"
            $0.layer.cornerRadius = 10
            $0.backgroundColor = UIColor.appColor(.cellBackground)
            $0.layer.borderColor = UIColor.gray.cgColor
            $0.layer.borderWidth = 0.1
            $0.dynamicFont(fontSize: 16, weight: .regular)
            $0.addLeftPadding(padding: 10)
            $0.delegate = self
            $0.inputAccessoryView = accessoryCompleteButton
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
            $0.layer.borderColor = UIColor.gray.cgColor
            $0.layer.borderWidth = 0.1
            $0.backgroundColor = .appColor(.cellBackground)
            $0.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 6)
            $0.inputAccessoryView = accessoryCompleteButton
        }
        self.completeButton.do {
            $0.backgroundColor = .appColor(.mainColor)
            $0.setTitle("수정완료", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.layer.cornerRadius = 10
            $0.addTarget(self, action: #selector(completeModify), for: .touchUpInside)
        }
        self.accessoryCompleteButton.do {
            $0.setTitle("완료", for: .normal)
            $0.backgroundColor = .appColor(.mainColor)
            $0.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 45)
            $0.addTarget(self, action: #selector(completeModify), for: .touchUpInside)
        }
    }
    
    // MARK: Set Layout
    
    func layout() {
        [profileImage, imageModify, nameLabel, name, introductionLabel, introduction, completeButton]
            .forEach { self.view.addSubview($0) }
        
        self.profileImage.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertHeight(value: 100)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeight(value: 100)).isActive = true
        }
        self.imageModify.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.bottomAnchor.constraint(equalTo: self.profileImage.bottomAnchor,
                                       constant: -Terminal.convertHeight(value: 4)).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.profileImage.trailingAnchor,
                                         constant: -Terminal.convertHeight(value: 4)).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertHeight(value: 25)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeight(value: 25)).isActive = true
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
            $0.heightAnchor.constraint(equalToConstant: 50).isActive = true
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
            $0.heightAnchor.constraint(equalToConstant: 200).isActive = true
        }
        self.completeButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 50).isActive = true
            $0.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10).isActive = true
        }
        
        self.topAnchor = self.profileImage.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10)
        self.topAnchor?.isActive = true
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        self.keyboardHandle(notification: notification, isAppear: true)
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.keyboardHandle(notification: notification, isAppear: false)
    }
        
    private func keyboardHandle(notification: NSNotification, isAppear: Bool) {
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardFrame: NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        
        let durationKey = UIResponder.keyboardAnimationDurationUserInfoKey
        let duration = notification.userInfo![durationKey] as! Double
        let withDuration = duration.isZero ? 0.25 : duration
        self.keyboardDuartion = withDuration
        
        let height = self.view.frame.height - self.introduction.frame.maxY
        let value = keyboardRectangle.height - height + 20
        self.contentHeight = value
        
        if !isAppear {
            self.topAnchor?.constant = 20
            UIView.animate(withDuration: withDuration) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc func didImageViewClicked() {
        let alert = UIAlertController(title: "대표 사진 설정", message: nil, preferredStyle: .actionSheet)
        let library = UIAlertAction(title: "사진앨범", style: .default) { _ in self.openLibrary() }
        let camera = UIAlertAction(title: "카메라", style: .default) { _ in self.openCamera() }
        let remove = UIAlertAction(title: "삭제", style: .destructive) { _ in }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(library)
        alert.addAction(camera)
        if self.profileExistence {
            alert.addAction(remove)
        }
        alert.addAction(cancel)
        
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            if let popoverController = alert.popoverPresentationController {
                popoverController.sourceView = self.view
                popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
                popoverController.permittedArrowDirections = []
                self.present(alert, animated: true, completion: nil)
            }
        } else {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openLibrary() {
        picker.allowsEditing = true
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
        let image           = self.profileImage.image!
        
        // 공백체크
        if nickname.whitespaceCheck() {
            self.showToast(controller: self, message: "이름은 공백이 포함되지 않습니다.", seconds: 0.5)
        } else {
            let profile = Profile(profileImage: image, nickname: nickname, introduction: introduction)
            showLoading()
            presenter?.completeModify(profile: profile)
            if self.profile?.profileImage != profile.profileImage {
                presenter?.completeImageModify(image: image)
            }
        }
        
        self.name.layer.borderWidth = 0.1
        self.name.layer.borderColor = UIColor.gray.cgColor
        self.introduction.layer.borderWidth = 0.1
        self.introduction.layer.borderColor = UIColor.gray.cgColor
    }
}

extension ProfileModifyView: ProfileModifyViewProtocol {
    func modifyResultHandle(result: Bool, message: String) {
        if result {
            print("수정 여부:", result)
            print("메시지 : ", message)
            let parent = self.navigationController?.viewControllers[1] as? ProfileDetailView
            self.navigationController?.popViewController(animated: true) {
                parent?.showToast(controller: parent!, message: "프로필 수정 완료", seconds: 1)
                parent?.presenter?.viewDidLoad()
            }
            
            let rootParent = self.navigationController?.viewControllers[0] as? SetView
            rootParent?.presenter?.viewDidLoad()
        } else {
            hideLoading()
            showToast(controller: self, message: message, seconds: 1)
        }
    }
    
    func showError(message: String, label: String) {
        showToast(controller: self, message: message, seconds: 1) {
            switch label {
            case "nickname":
                self.name.warningEffect()
            case "introduce":
                self.introduction.warningEffect()
            default:
                break
            }
        }
    }
    
    func showLoading() {
        LoadingRainbowCat.show(caller: self)
    }
    
    func hideLoading() {
        LoadingRainbowCat.hide(caller: self)
    }
}

// MARK: 이미지 픽커

extension ProfileModifyView: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
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
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.topAnchor?.constant = -self.contentHeight
        UIView.animate(withDuration: self.keyboardDuartion) {
            self.view.layoutIfNeeded()
        }
    }
}
