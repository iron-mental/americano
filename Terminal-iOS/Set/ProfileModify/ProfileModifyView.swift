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

class ProfileModifyView: UIViewController, CellSubclassDelegate {
    var presenter: ProfileModifyPresenterProtocol?
    var userInfo: UserInfo?
    var projectArr: [Project] = []
    let picker = UIImagePickerController()
    
    let projectView = ProjectTableView()

    let projectAddButton = UIButton()
    
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
    lazy var snsModify = ProfileSNSView()
    lazy var emailModify = EmailModifyView()
    lazy var locationModify = LocationModifyView()

    // MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        presenter?.viewDidLoad()
        attribute()
        layout()
        textViewDidChange(descripModify)
        textViewDidChange(careerDescriptModify)
        textViewDidChange(projectDescriptModify)
    }
    
    // MARK: Set Attribute
    func attribute() {
        let modifyBtn = UIBarButtonItem(image: #imageLiteral(resourceName: "Vaild"),
                                        style: .plain,
                                        target: self,
                                        action: #selector(completeButton))
        self.do {
            $0.navigationItem.rightBarButtonItem = modifyBtn
        }
        picker.do {
            $0.delegate = self
        }
        
        scrollView.do {
            $0.delegate = self
            $0.bounces = false
        }
        
        backgroundView.do {
            let background = UITapGestureRecognizer(target: self, action: #selector(backgroundTap))
            background.numberOfTapsRequired = 1
            background.isEnabled = true
            background.cancelsTouchesInView = false
            $0.addGestureRecognizer(background)
        }
        
        let token = KeychainWrapper.standard.string(forKey: "accessToken")!
        let imageDownloadRequest = AnyModifier { request in
            var requestBody = request
            requestBody.setValue("Bearer "+token, forHTTPHeaderField: "Authorization")
            return requestBody
        }
        
        profileImage.do {
            if let image = userInfo?.image {
                $0.kf.setImage(with: URL(string: image),
                               options: [.requestModifier(imageDownloadRequest)])
            } else {
                $0.image = #imageLiteral(resourceName: "member")
            }
            let profileTapGesture = UITapGestureRecognizer(target: self, action: #selector(didImageViewClicked))
            $0.addGestureRecognizer(profileTapGesture)
            $0.backgroundColor = UIColor.appColor(.terminalBackground)
            $0.contentMode = .scaleAspectFill
            $0.frame.size.width = Terminal.convertHeigt(value: 100)
            $0.frame.size.height = Terminal.convertHeigt(value: 100)
            $0.layer.cornerRadius = $0.frame.width / 2
            $0.clipsToBounds = true
            $0.isUserInteractionEnabled = true
            $0.backgroundColor = .blue
        }
        
        nameModify.do {
            guard let name = userInfo?.nickname else { return }
            $0.text = name
            $0.font = UIFont(name: nameModify.font!.fontName, size: 20)
            $0.placeholder = "닉네임"
            $0.dynamicFont(fontSize: 20, weight: .semibold)
        }
        
        descripModify.do {
            $0.backgroundColor = .darkGray
            if let descript = userInfo?.introduce {
                $0.text = descript
            }
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
        
        careerLabel.do {
            $0.text = "경력"
            $0.textColor = .white
        }
        
        careerTitleModify.do {
            if let career = userInfo?.careerTitle {
                $0.text = career
            }
            $0.placeholder = "타이틀"
            $0.addLeftPadding()
            $0.backgroundColor = .red
            $0.textColor = .white
            $0.dynamicFont(fontSize: 16, weight: .bold)
            $0.textAlignment = .left
            $0.delegate = self
            $0.layer.cornerRadius = 10
            $0.backgroundColor = UIColor.appColor(.cellBackground)
        }
        
        careerDescriptModify.do {
            if let career = userInfo?.careerContents {
                $0.text = career
            }
            $0.backgroundColor = .red
            $0.textColor = UIColor.appColor(.profileTextColor)
            $0.dynamicFont(size: 14, weight: .regular)
            $0.delegate = self
            $0.sizeToFit()
            $0.textContainer.lineFragmentPadding = 0
            $0.textContainerInset = .zero
            $0.layer.masksToBounds = true
            $0.isScrollEnabled = false
            $0.layer.cornerRadius = 10
            $0.backgroundColor = UIColor.appColor(.cellBackground)
            $0.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 6)
        }
        
        projectLabel.do {
            $0.text = "프로젝트"
            $0.textColor = .white
        }
        
        projectView.do {
            $0.isScrollEnabled = false
            $0.delegate = self
            $0.dataSource = self
            $0.separatorStyle = .none
            $0.register(ProjectCell.self, forCellReuseIdentifier: ProjectCell.projectCellID)
            $0.estimatedRowHeight = 44
            $0.rowHeight = UITableView.automaticDimension
        }
        
        projectAddButton.do {
            $0.setTitleColor(.white, for: .normal)
            if projectArr.count == 3 {
                $0.backgroundColor = .darkGray
            } else {
                $0.backgroundColor = UIColor.appColor(.mainColor)
            }
            $0.setTitle(" + 프로젝트 추가", for: .normal)
            $0.layer.cornerRadius = 10
            $0.addTarget(self, action: #selector(addProject), for: .touchUpInside)
        }
        
        guard let email = userInfo?.email else { return }
        emailModify.do {
            $0.emailTextField.text = email
        }
        
        guard let location = userInfo?.address else { return }
        locationModify.do {
            $0.locationTextField.text = location
            $0.locationTextField.delegate = self
        }
        snsModify.do {
            $0.firstTextFeield.delegate = self
            $0.secondTextField.delegate = self
            $0.thirdTextField.delegate = self
        }
    }
    
    // MARK: Set Layout
    
    func layout() {
        view.addSubview(scrollView)
        scrollView.addSubview(backgroundView)
        [profileImage, nameModify, descripModify, careerLabel, careerTitleModify, careerDescriptModify, projectLabel, projectView, projectAddButton, snsModify, emailModify, locationModify].forEach { backgroundView.addSubview($0) }
        
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
            $0.heightAnchor.constraint(equalToConstant: 50).isActive = true
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
        projectView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: projectLabel.bottomAnchor, constant: 4).isActive = true
            $0.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 10).isActive = true
            $0.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -10).isActive = true
        }
        projectAddButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: projectView.bottomAnchor).isActive = true
            $0.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 30).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 130).isActive = true
        }
        snsModify.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: projectAddButton.bottomAnchor, constant: 30).isActive = true
            $0.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor).isActive = true
            $0.heightAnchor.constraint(equalTo: snsModify.heightAnchor).isActive = true
        }
        emailModify.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: snsModify.bottomAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 25).isActive = true
            $0.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -25).isActive = true
            $0.heightAnchor.constraint(equalTo: emailModify.heightAnchor).isActive = true
        }
        locationModify.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: emailModify.bottomAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 25).isActive = true
            $0.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -25).isActive = true
            $0.heightAnchor.constraint(equalTo: locationModify.heightAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -20).isActive = true
        }
    }
    
    @objc func backgroundTap() {
        self.view.endEditing(true)
    }
    
    @objc func addProject() {
        if projectArr.count < 3 {
            let project = Project(id: nil, title: "", contents: "", snsGithub: "", snsAppstore: "", snsPlaystore: "", createAt: "")
            projectArr.append(project)
            projectView.insertRows(at: [IndexPath(row: projectArr.count - 1, section: 0)], with: .right)
            if projectArr.count == 3 {
                projectAddButton.backgroundColor = .darkGray
            }
        } else {
            let alert = UIAlertController(title: "알림",
                                          message: "프로젝트는 최대 3개입니다.",
                                          preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "확인", style: .default, handler: nil )

            alert.addAction(okAction)
            present(alert, animated: true)
        }
    }
    
    @objc func didImageViewClicked() {
        let alert =  UIAlertController(title: "대표 사진 설정", message: nil, preferredStyle: .actionSheet)
        let library =  UIAlertAction(title: "사진앨범", style: .default) { _ in self.openLibrary() }
        let camera =  UIAlertAction(title: "카메라", style: .default) { _ in self.openCamera() }
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
    
    func getCellData() {
        for index in 0..<projectArr.count {
            let indexpath = IndexPath(row: index, section: 0)
            let cell = projectView.cellForRow(at: indexpath) as! ProjectCell
            let title = cell.title.text!
            let contents = cell.contents.text!
            let github = cell.sns.firstTextFeield.text
            let appStore = cell.sns.secondTextField.text
            let playStore = cell.sns.secondTextField.text
        
            projectArr[index] = Project(id: nil,
                                        title: title,
                                        contents: contents,
                                        snsGithub: github,
                                        snsAppstore: appStore,
                                        snsPlaystore: playStore,
                                        createAt: "")
        }
    }

    // MARK: - 프로필 수정 완료 버튼
    
    @objc func completeButton() {
        getCellData()

        guard let image = profileImage.image,
              let nickname = nameModify.text,
              let introduce = descripModify.text,
              let careerTitle = careerTitleModify.text,
              let careerContents = careerDescriptModify.text,
              let snsGithub = snsModify.firstTextFeield.text,
              let snsLinkedIn = snsModify.secondTextField.text,
              let snsWeb = snsModify.thirdTextField.text else { return }

        let userInfo = UserInfoPut(image: image,
                                   nickname: nickname,
                                   introduce: introduce,
                                   careerTitle: careerTitle,
                                   careerContents: careerContents,
                                   snsGithub: snsGithub,
                                   snsLinkedIn: snsLinkedIn,
                                   snsWeb: snsWeb,
                                   latitude: 37.602500,
                                   longitude: 126.929340,
                                   sido: "서울시",
                                   sigungu: "은평구")

        presenter?.completeModifyButton(userInfo: userInfo, project: projectArr)
        
        let view = self.navigationController?.rootViewController as? SetViewProtocol
        
        self.navigationController?.popToRootViewController(animated: true, completion: {
            view!.presenter?.viewDidLoad()
        })
    }
}

extension ProfileModifyView: ProfileModifyViewProtocol {

}

// MARK: 테이블뷰

extension ProfileModifyView: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projectArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = projectView.dequeueReusableCell(withIdentifier: ProjectCell.projectCellID, for: indexPath) as! ProjectCell
        cell.title.delegate = self
        cell.selectionStyle = .none
        cell.delegate = self
        let result = projectArr[indexPath.row]
        cell.setData(data: result)
        return cell
    }
    
    func buttonTapped(cell: ProjectCell) {
        guard let indexPath = self.projectView.indexPath(for: cell) else {
            return
        }
        
        let index = indexPath.row
        
        self.projectArr.remove(at: index)
        self.projectView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .fade)
        self.projectAddButton.backgroundColor =
            self.projectArr.count < 3 ? UIColor.appColor(.mainColor) : UIColor.darkGray
    }
}

// MARK: 이미지 픽커

extension ProfileModifyView: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
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
    
    // MARK: TextView Dynamic Height
    
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
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
}
