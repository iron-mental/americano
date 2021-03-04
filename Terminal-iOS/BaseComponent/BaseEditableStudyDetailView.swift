//
//  BaseEditableStudyDetailView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/19.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit
import AVFoundation

class BaseEditableStudyDetailView: UIViewController {
    deinit { self.keyboardRemoveObserver() }
    
    var studyDetailPost: StudyDetailPost?
    
    // UI
    let mainImageView = MainImageView(frame: CGRect.zero)
    let studyTitleTextField = UITextField()
    var studyIntroduceView = TitleWithTextView(title: "스터디 소개")
    var SNSInputView = IdInputView()
    var studyInfoView = TitleWithTextView(title: "스터디 진행")
    var locationView = LocationUIView()
    var timeView = TimeUIView()
    var completeButton = UIButton()
    var accessoryCompleteButton = UIButton()
    var backgroundView = UIView()
    let scrollView = UIScrollView()
    let picker = UIImagePickerController()
    var clickedView: UIView?
    
    // State
    let screenSize = UIScreen.main.bounds
    var keyboardHeight: CGFloat = 0.0
    var selectedCategory: String?
    var currentScrollViewMinY: CGFloat = 0
    var currentScrollViewMaxY: CGFloat = 0
    var selectedLocation: StudyDetailLocationPost?
    var textViewTapFlag = false
    var standardContentHeight: CGFloat = 0.0
    var viewDidAppearFlag = true
    
    // MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
        setDelegate()
        self.hideKeyboardWhenTappedAround()
        self.keyboardAddObserver(showSelector: #selector(keyboardWillShow),
                                 hideSelector: #selector(keyboardWillHide))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if self.viewDidAppearFlag {
            self.studyTitleTextField.becomeFirstResponder()
            self.viewDidAppearFlag.toggle()
        }
        self.standardContentHeight = self.scrollView.contentSize.height
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardFrame: NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        self.keyboardHeight = keyboardRectangle.height
        self.textViewTapFlag = false
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.completeButton.alpha = 1
        self.scrollView.contentSize.height = self.standardContentHeight
    }
    
    func setDelegate(completion: (() -> Void)? = nil) {
        scrollView.delegate = self
        studyTitleTextField.delegate = self
        studyIntroduceView.textView.delegate = self
        studyInfoView.textView.delegate = self
        SNSInputView.notion.textField.delegate = self
        SNSInputView.evernote.textField.delegate = self
        SNSInputView.web.textField.delegate = self
        locationView.detailAddress.delegate = self
        timeView.detailTime.delegate = self
        picker.delegate = self
        
        SNSInputView.notion.textField.debounce(delay: 1) { [weak self] _ in
            //첫 로드 시 한번 실행되는 거는 분기처리를 해주자 text.isEmpty 등등으로 해결볼 수 있을 듯
            guard let text = self?.SNSInputView.notion.textField.text else { return }
            if text.notionCheck() || text.isEmpty {
                self!.SNSInputView.notion.textField.layer.borderColor = .none
            } else {
                self!.SNSInputView.notion.textField.layer.borderColor = UIColor.systemRed.cgColor
            }
        }
        
        SNSInputView.evernote.textField.debounce(delay: 1) { [weak self] _ in
            guard let text = self?.SNSInputView.evernote.textField.text else { return }
            if text.evernoteCheck() || text.isEmpty {
                self!.SNSInputView.evernote.textField.layer.borderColor = .none
            } else {
                self!.SNSInputView.evernote.textField.layer.borderColor = UIColor.systemRed.cgColor
            }
        }
        
        SNSInputView.web.textField.debounce(delay: 1) { [weak self] _ in
            guard let text = self?.SNSInputView.web.textField.text else { return }
            if text.webCheck() || text.isEmpty {
                self!.SNSInputView.web.textField.layer.borderColor = .none
            } else {
                self!.SNSInputView.web.textField.layer.borderColor = UIColor.systemRed.cgColor
            }
        }
    }
    
    func attribute() {
        self.do {
            $0.navigationItem.largeTitleDisplayMode = .never
            $0.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back",
                                                                  style: UIBarButtonItem.Style.plain,
                                                                  target: nil,
                                                                  action: nil)
            $0.view.backgroundColor = .appColor(.testColor)
        }
        backgroundView.do {
            $0.backgroundColor = .appColor(.terminalBackground)
        }
        scrollView.do {
            $0.backgroundColor = .appColor(.testColor)
        }
        mainImageView.do {
            $0.editMode()
            $0.contentMode = .scaleAspectFill
            $0.layer.masksToBounds = true
            $0.alpha = 0.7
            let mainImageTapGesture = UITapGestureRecognizer(target: self,
                                                             action: #selector(didImageViewClicked))
            $0.addGestureRecognizer(mainImageTapGesture)
        }
        studyTitleTextField.do {
            $0.tag = 1
            $0.placeholder = "스터디 이름을 입력하세요"
            $0.backgroundColor = .appColor(.InputViewColor)
            $0.textAlignment = .center
            $0.textColor = .white
            $0.layer.cornerRadius = 10
            $0.dynamicFont(fontSize: $0.font!.pointSize, weight: .medium)
            $0.inputAccessoryView = accessoryCompleteButton
            $0.layer.borderWidth = 0.1
            $0.layer.borderColor = UIColor.gray.cgColor
        }
        studyIntroduceView.do {
            $0.backgroundColor = .appColor(.testColor)
            $0.categoryLabel.text = selectedCategory
            $0.textView.inputAccessoryView = accessoryCompleteButton
        }
        SNSInputView.do {
            $0.backgroundColor = .appColor(.testColor)
            $0.notion.textField.inputAccessoryView = accessoryCompleteButton
            $0.evernote.textField.inputAccessoryView = accessoryCompleteButton
            $0.web.textField.inputAccessoryView = accessoryCompleteButton
        }
        studyInfoView.do {
            $0.backgroundColor = .appColor(.testColor)
            $0.textView.inputAccessoryView = accessoryCompleteButton
        }
        locationView.do {
            $0.backgroundColor = .appColor(.testColor)
            let locationTapGesture = UITapGestureRecognizer(target: self,
                                                            action: #selector(didLocationViewClicked))
            $0.addGestureRecognizer(locationTapGesture)
            $0.detailAddress.inputAccessoryView = accessoryCompleteButton
        }
        timeView.do {
            $0.backgroundColor = .appColor(.testColor)
            $0.detailTime.inputAccessoryView = accessoryCompleteButton
        }
        completeButton.do {
            $0.setTitle("완료", for: .normal)
            $0.backgroundColor = .appColor(.mainColor)
            $0.titleLabel?.dynamicFont(fontSize: 15, weight: .bold)
            $0.layer.cornerRadius = 10
            $0.layer.masksToBounds = true
        }
        accessoryCompleteButton.do {
            $0.setTitle("완료", for: .normal)
            $0.titleLabel?.dynamicFont(fontSize: 15, weight: .bold)
            $0.backgroundColor = .appColor(.mainColor)
            $0.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 45)
        }
    }
    
    func layout() {
        view.addSubview(scrollView)
        scrollView.addSubview(backgroundView)
        [mainImageView,
         studyTitleTextField,
         studyIntroduceView,
         SNSInputView,
         studyInfoView,
         locationView,
         timeView,
         completeButton].forEach { backgroundView.addSubview($0)}
        
        scrollView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        }
        backgroundView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor).isActive = true
        }
        mainImageView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.widthAnchor.constraint(equalTo: backgroundView.widthAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeight(value: 170)).isActive = true
            $0.topAnchor.constraint(equalTo: backgroundView.topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor).isActive = true
        }
        studyTitleTextField.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: mainImageView.bottomAnchor,
                                    constant: -((((55/667) * screenSize.height) * 16) / 55)).isActive = true
            $0.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
            $0.widthAnchor.constraint(equalToConstant: (300/375) * screenSize.width).isActive = true
            $0.heightAnchor.constraint(equalToConstant: (55/667) * screenSize.height).isActive = true
        }
        studyIntroduceView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: studyTitleTextField.bottomAnchor,
                                    constant: Terminal.convertHeight(value: 23)).isActive = true
            $0.leadingAnchor.constraint(equalTo: backgroundView.safeAreaLayoutGuide.leadingAnchor,
                                        constant: Terminal.convertWidth(value: 15) ).isActive = true
            $0.trailingAnchor.constraint(equalTo: backgroundView.safeAreaLayoutGuide.trailingAnchor,
                                         constant: Terminal.convertWidth(value: -15) ).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeight(value: 141)).isActive = true
        }
        SNSInputView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: studyIntroduceView.bottomAnchor,
                                    constant: Terminal.convertHeight(value: 23)).isActive = true
            $0.leadingAnchor.constraint(equalTo: backgroundView.safeAreaLayoutGuide.leadingAnchor,
                                        constant: Terminal.convertWidth(value: 15) ).isActive = true
            $0.trailingAnchor.constraint(equalTo: backgroundView.safeAreaLayoutGuide.trailingAnchor,
                                         constant: Terminal.convertWidth(value: -15) ).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeight(value: 141)).isActive = true
        }
        studyInfoView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: SNSInputView.bottomAnchor,
                                    constant: Terminal.convertHeight(value: 23)).isActive = true
            $0.leadingAnchor.constraint(equalTo: backgroundView.safeAreaLayoutGuide.leadingAnchor,
                                        constant: Terminal.convertWidth(value: 15) ).isActive = true
            $0.trailingAnchor.constraint(equalTo: backgroundView.safeAreaLayoutGuide.trailingAnchor,
                                         constant: Terminal.convertWidth(value: -15) ).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeight(value: 141)).isActive = true
        }
        locationView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: studyInfoView.bottomAnchor,
                                    constant: Terminal.convertHeight(value: 23)).isActive = true
            $0.leadingAnchor.constraint(equalTo: backgroundView.safeAreaLayoutGuide.leadingAnchor,
                                        constant: Terminal.convertWidth(value: 15) ).isActive = true
            $0.trailingAnchor.constraint(equalTo: backgroundView.safeAreaLayoutGuide.trailingAnchor,
                                         constant: Terminal.convertWidth(value: -15) ).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeight(value: 141)).isActive = true
        }
        timeView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: locationView.bottomAnchor,
                                    constant: Terminal.convertHeight(value: 23)).isActive = true
            $0.trailingAnchor.constraint(equalTo: backgroundView.safeAreaLayoutGuide.trailingAnchor,
                                         constant: Terminal.convertWidth(value: -15) ).isActive = true
            $0.leadingAnchor.constraint(equalTo: backgroundView.safeAreaLayoutGuide.leadingAnchor,
                                        constant: Terminal.convertWidth(value: 15) ).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeight(value: 100)).isActive = true
        }
        completeButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: timeView.bottomAnchor,
                                    constant: Terminal.convertHeight(value: 23)).isActive = true
            $0.trailingAnchor.constraint(equalTo: backgroundView.safeAreaLayoutGuide.trailingAnchor,
                                         constant: Terminal.convertWidth(value: -15) ).isActive = true
            $0.leadingAnchor.constraint(equalTo: backgroundView.safeAreaLayoutGuide.leadingAnchor,
                                        constant: Terminal.convertWidth(value: 15) ).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeight(value: 50)).isActive = true
            $0.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor).isActive = true
        }
    }
    
    func resetInputTextLayer() {
        self.studyTitleTextField.layer.borderWidth = 0.1
        self.studyTitleTextField.layer.borderColor = UIColor.gray.cgColor
        self.studyIntroduceView.textView.layer.borderWidth = 0.1
        self.studyIntroduceView.textView.layer.borderColor = UIColor.gray.cgColor
        self.studyInfoView.textView.layer.borderWidth = 0.1
        self.studyInfoView.textView.layer.borderColor = UIColor.gray.cgColor
        self.timeView.detailTime.layer.borderWidth = 0.1
        self.timeView.detailTime.layer.borderColor = UIColor.gray.cgColor
        self.SNSInputView.notion.textField.layer.borderWidth = 0.1
        self.SNSInputView.notion.textField.layer.borderColor = UIColor.gray.cgColor
        self.SNSInputView.evernote.textField.layer.borderWidth = 0.1
        self.SNSInputView.evernote.textField.layer.borderColor = UIColor.gray.cgColor
        self.SNSInputView.web.textField.layer.borderWidth = 0.1
        self.SNSInputView.web.textField.layer.borderColor = UIColor.gray.cgColor
    }
    
    @objc func didImageViewClicked() {
        let alert = UIAlertController(title: "대표 사진 설정", message: nil, preferredStyle: .actionSheet)
        let library = UIAlertAction(title: "사진앨범", style: .default) { _ in self.openLibrary() }
        let camera = UIAlertAction(title: "카메라", style: .default) { _ in self.openCamera() }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(library)
        alert.addAction(camera)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // override point
    @objc func didLocationViewClicked() {
    }
    
    func openLibrary() {
        self.picker.sourceType = .photoLibrary
        self.present(self.picker, animated: true, completion: nil)
    }
    
    func openCamera() {
        let cameraAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
            
        switch cameraAuthorizationStatus {
        case .authorized:
            self.picker.sourceType = .camera
            self.present(self.picker, animated: true, completion: nil)
        case .notDetermined, .denied, .restricted:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                guard granted == true else {
                    DispatchQueue.main.async {
                        self.showToast(controller: self, message: "카메라 사용 옵션을 허용해주세요.", seconds: 1)
                    }
                    return
                }
                self.picker.sourceType = .camera
                self.present(self.picker, animated: true, completion: nil)
            }
        @unknown default:
            self.showToast(controller: self, message: "카메라 사용 옵션을 허용해주세요.", seconds: 1)
        }
    }
    
    func editableViewDidTap(textView: UIView, viewMinY: CGFloat, viewMaxY: CGFloat) {
        var parentView = UIView()
        if type(of: textView) == SNSInputUITextField.self {
            parentView = (textView.superview?.superview)!
        } else {
            parentView = textView.tag == 1 ? textView : textView.superview!
        }
        
        if viewMinY >= (parentView.frame.minY) {
            let distance = (parentView.frame.minY) - viewMinY
            self.viewSetTop(distance: distance - accessoryCompleteButton.frame.height)
        } else if viewMaxY <= (parentView.frame.maxY) {
            let distance = (parentView.frame.maxY) - viewMaxY
            self.viewSetBottom(distance: distance + accessoryCompleteButton.frame.height)
        } else {
            self.textViewTapFlag = false
        }
    }
    
    func viewSetTop(distance: CGFloat) {
        self.completeButton.alpha = 0
        UIView.animate(withDuration: 0.2) {
            self.scrollView.contentOffset.y += distance
        } completion: { _ in
            self.clickedView?.becomeFirstResponder()
            self.textViewTapFlag = false
        }
    }
    
    func viewSetBottom(distance: CGFloat) {
        self.completeButton.alpha = 0
        UIView.animate(withDuration: 0.2) {
            self.scrollView.contentSize.height += distance
            self.scrollView.contentOffset.y += distance
        } completion: { _ in
            self.clickedView?.becomeFirstResponder()
            self.textViewTapFlag = false
        }
    }
}

extension BaseEditableStudyDetailView: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.mainImageView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
}

extension BaseEditableStudyDetailView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.textViewTapFlag = true
        self.clickedView = textField
        
        self.editableViewDidTap(textView: self.clickedView!,
                                viewMinY: CGFloat(self.currentScrollViewMinY),
                                viewMaxY: CGFloat(self.currentScrollViewMaxY))
    }
}

extension BaseEditableStudyDetailView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.textViewTapFlag = true
        self.clickedView = textView
        self.editableViewDidTap(textView: self.clickedView!,
                                viewMinY: CGFloat(self.currentScrollViewMinY),
                                viewMaxY: CGFloat(self.currentScrollViewMaxY))
    }
}

extension BaseEditableStudyDetailView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if type(of: scrollView) == UIScrollView.self {
            self.currentScrollViewMinY = scrollView.contentOffset.y
            self.currentScrollViewMaxY = (scrollView.contentOffset.y + scrollView.frame.height) - self.keyboardHeight
            if !textViewTapFlag {
                view.endEditing(true)
            }
        }
    }
}

extension BaseEditableStudyDetailView: selectLocationDelegate {
    func passLocation(location: StudyDetailLocationPost) {
        self.selectedLocation = location
        self.locationView.address.text = "\(location.address)"
        guard let detail = location.detailAddress else { return }
        self.locationView.detailAddress.text = detail
    }
}
