//
//  ProfileModifyView.swift
//  Terminal-iOS
//
//  Created by once on 2020/11/09.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class ProfileModifyView: UIViewController {
    var keyHeight: CGFloat?
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
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attribute()
        layout()
        registerForKeyboardNotification()
        textViewDidChange(descripModify)
        textViewDidChange(careerDescriptModify)
        textViewDidChange(projectDescriptModify)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        removeRegisterForKeyboardNotification()
    }
    
    // MARK: Set Attribute
    func attribute() {
        scrollView.do {
            $0.delegate = self
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
    
    // MARK: Set Layout
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
        snsModify.gitTextField.delegate = self
        snsModify.linkedTextField.delegate = self
        snsModify.webTextField.delegate = self
        locationModify.locationTextField.delegate = self
    }
    
    func registerForKeyboardNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeRegisterForKeyboardNotification(){
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //    @objc func keyboardHide(_ notification: Notification){
    //        self.view.transform = .identity
    //    }
    
    @objc func keyboardWillHide(_ sender: Notification) {
        self.view.frame.origin.y += keyHeight!
    }
    
    @objc func keyboardWillShow(_ sender: Notification) {
        let userInfo:NSDictionary = sender.userInfo! as NSDictionary
        let keyboardFrame:NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        keyHeight = keyboardHeight
        
        self.view.frame.origin.y -= keyboardHeight
    }
    //    @objc func keyBoardShow(notification: NSNotification){
    //        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
    //        let keyboardFrame: NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
    //        let keyboardRectangle = keyboardFrame.cgRectValue
    //        if projectTitleModify.isEditing == true{
    //            keyboardAnimate(keyboardRectangle: keyboardRectangle, textField: projectTitleModify)
    //        }
    //        else if nameModify.isEditing == true {
    //            keyboardAnimate(keyboardRectangle: keyboardRectangle, textField: nameModify)
    //        }
    //        else if snsModify.gitTextField.isEditing == true{
    //            print("sns1 호출")
    //            keyboardAnimate(keyboardRectangle: keyboardRectangle, textField: snsModify.gitTextField)
    //        }
    //        else if snsModify.linkedTextField.isEditing == true{
    //            print("sns2 호출")
    //            keyboardAnimate(keyboardRectangle: keyboardRectangle, textField: snsModify.linkedTextField)
    //        }
    //        else if snsModify.webTextField.isEditing == true{
    //            print("sns3 호출")
    //            keyboardAnimate(keyboardRectangle: keyboardRectangle, textField: snsModify.webTextField)
    //        } else if locationModify.locationTextField.isEditing == true {
    //            print("sns4 호출")
    //            keyboardAnimate(keyboardRectangle: keyboardRectangle, textField: locationModify.locationTextField)
    //        }
    //    }
    
    func keyboardAnimate(keyboardRectangle: CGRect ,textField: UITextField){
        //        print("전체 크기 :\(backgroundView.frame.height)")
        print("전체 크기 :\(view.frame.height)")
        print("키보드 크기 : \(keyboardRectangle.height)")
        print("뷰 프레임크기 - 텍스트필드 y값 : \(self.view.frame.height - textField.frame.maxY)")
        print("텍스트필드 값 : \(textField.frame.maxY)")
        //        self.view.frame.height
        if keyboardRectangle.height > (self.view.frame.height - textField.frame.maxY){
            self.view.transform = CGAffineTransform(translationX: 0, y: (view.frame.height - keyboardRectangle.height - textField.frame.maxY))
        }
    }
}

extension ProfileModifyView: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
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
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //        if scrollView.contentOffset.y - careerDescriptModify.frame.minY < 0 {
        //            scrollView.contentOffset.y = careerDescriptModify.frame.minY
        //        }
        //        print(scrollView.contentOffset.y - careerDescriptModify.frame.minY)
        //        print(scrollView.contentOffset.y - projectDescriptModify.frame.minY)
        //scrolloffy = 0
        
        //        let userInfo:NSDictionary = sender.userInfo! as NSDictionary
        //        let keyboardFrame:NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
        //        let keyboardRectangle = keyboardFrame.cgRectValue
        //        let keyboardHeight = keyboardRectangle.height
        //        keyHeight = keyboardHeight
        
        //        if let height = keyHeight {
        //        print("맨위",scrollView.contentOffset.y)
        //        careerDescriptModify.frame.miny
        
        if scrollView.contentOffset.y > projectLabel.frame.minY {
            print("위에 짤린다.")
        } else if ((690 - (280 + 60 )) + scrollView.contentOffset.y) < projectLabel.frame.maxY {
            print("밑에 짤린다.")
            print("위로 올려줘야하는 만큼이 이정도",projectLabel.frame.maxY - ((690 - (280 + 60 )) + scrollView.contentOffset.y))
        } else {
            print("안짤린다.")
        }
    }
}
