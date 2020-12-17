//
//  CreateStudyView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/15.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import Kingfisher
import SwiftKeychainWrapper

class CreateStudyView: UIViewController{
    var presenter: CreateStudyPresenterProtocols?
    
    var parentView: UIViewController?
    let screenSize = UIScreen.main.bounds
    var selectedCategory: String?
    var selectedLocation: StudyDetailLocationPost? {
        didSet {
            self.button.alpha = 1
            self.button.isUserInteractionEnabled = true
        }
    }
    let picker = UIImagePickerController()
    var backgroundView = UIView()
    let scrollView = UIScrollView()
    var state: WriteStudyViewState? {
        didSet {
            attribute()
        }
    }
    let mainImageView = MainImageView(frame: CGRect.zero)
    let studyTitleTextField = UITextField()
    var seletedCategory: String?
    var studyIntroduceView = TitleWithTextView(title: "스터디 소개")
    var SNSInputView = IdInputView()
    var studyInfoView = TitleWithTextView(title: "스터디 진행")
    var locationView = LocationUIView()
    var timeView = TimeUIView()
    var button = UIButton()
    var mainImageTapGesture = UITapGestureRecognizer()
    var locationTapGesture = UITapGestureRecognizer()
    var studyDetailPost: StudyDetailPost?
    var keyboardHeight: CGFloat = 0.0
    var clickedView: UIView?
    var currentScrollViewMinY: CGFloat = 0
    var currentScrollViewMaxY: CGFloat = 0
    var textViewTapFlag = false
    var keyboardLine: UIView {
        var view = UIView()
        view.backgroundColor = .red
        view.frame = CGRect(x: 0, y: UIScreen.main.bounds.height - 291 , width: UIScreen.main.bounds.width, height: 1)
        return view
    }
    let imageDownloadRequest = AnyModifier { request in
        var requestBody = request
        requestBody.setValue(Terminal.token, forHTTPHeaderField: "Authorization")
        return requestBody
    }
    var study: StudyDetail? {
        didSet {
            setView()
        }
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc func keyboardWillShow(notification:NSNotification) {
        let userInfo:NSDictionary = notification.userInfo! as NSDictionary
        let keyboardFrame:NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        keyboardHeight = keyboardRectangle.height
    }
    
    @objc func keyboardWillHide() {
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func attribute() {
        let token = KeychainWrapper.standard.string(forKey: "accessToken")!
        let imageDownloadRequest = AnyModifier { request in
            var requestBody = request
            requestBody.setValue("Bearer "+token, forHTTPHeaderField: "Authorization")
            return requestBody
        }
        view.do {
            $0.backgroundColor = UIColor.appColor(.testColor)
        }
        scrollView.do {
            $0.backgroundColor = UIColor.appColor(.testColor)
            $0.showsVerticalScrollIndicator = false
        }
        backgroundView.do {
            $0.backgroundColor = UIColor.appColor(.testColor)
        }
        mainImageView.do {
            $0.alpha = 0.7
            $0.image = #imageLiteral(resourceName: "swift")
            mainImageTapGesture = UITapGestureRecognizer(target: self, action: #selector(didImageViewClicked))
            $0.addGestureRecognizer(mainImageTapGesture)
            //추후에 수정일때인지 새로작성인지 분기해서 처리 ~(철이형 얘기하는거 아님)
            //            $0.kf.setImage(with: URL(string: (study?.image!)!), options: [.requestModifier(imageDownloadRequest)])
        }
        studyTitleTextField.do {
            $0.placeholder = "스터디 이름을 입력하세요"
            $0.backgroundColor = UIColor.appColor(.InputViewColor)
            $0.textAlignment = .center
            $0.textColor = .white
            $0.text = study?.title ?? nil
            $0.layer.cornerRadius = 10
            $0.dynamicFont(fontSize: $0.font!.pointSize, weight: .semibold)
        }
        
        studyIntroduceView.do {
            $0.backgroundColor = UIColor.appColor(.testColor)
            $0.textView.text = study?.introduce ?? nil
        }
        SNSInputView.do {
            $0.backgroundColor = UIColor.appColor(.testColor)
            $0.notion.textField.text = study?.snsNotion ?? nil
            $0.web.textField.text = study?.snsNotion ?? nil
            $0.evernote.textField.text = study?.snsNotion ?? nil
        }
        studyInfoView.do {
            $0.backgroundColor = UIColor.appColor(.testColor)
            $0.textView.text = study?.introduce ?? nil
        }
        locationView.do {
            $0.backgroundColor = UIColor.appColor(.testColor)
            locationTapGesture = UITapGestureRecognizer(target: self, action: #selector(didLocationViewClicked))
            $0.addGestureRecognizer(locationTapGesture)
            $0.address.text = study?.location.addressName != nil ? ". \(study?.location.addressName)" : "  주소입력"
            $0.detailAddress.text =  study?.location.locationDetail ?? nil
        }
        timeView.do {
            $0.backgroundColor = UIColor.appColor(.testColor)
            $0.detailTime.text = study?.studyTime ?? nil
        }
        
        button.do {
            $0.setTitle("완료", for: .normal)
            $0.backgroundColor = UIColor(named: "key")
            $0.layer.cornerRadius = 10
            $0.layer.masksToBounds = true
            $0.addTarget(self, action: #selector(didClickButton), for: .touchUpInside)
            $0.isUserInteractionEnabled = state == .edit ? true : false
            self.button.alpha =  state == .edit ?  1 : 0.5
        }
    }
    
    func layout() {
        view.addSubview(scrollView)
        view.addSubview(keyboardLine)
        scrollView.addSubview(backgroundView)
        [mainImageView, studyTitleTextField, studyIntroduceView, SNSInputView, studyInfoView, locationView, timeView, button].forEach { backgroundView.addSubview($0)}
        
        scrollView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            $0.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        }
        backgroundView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
            $0.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
            $0.heightAnchor.constraint(equalTo: scrollView.heightAnchor, constant: 600).isActive = true
            $0.bottomAnchor.constraint(equalTo: button.bottomAnchor).isActive = true
        }
        mainImageView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.widthAnchor.constraint(equalToConstant: screenSize.width).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeigt(value: 170)).isActive = true
            $0.topAnchor.constraint(equalTo: backgroundView.topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor).isActive = true
        }
        studyTitleTextField.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: mainImageView.bottomAnchor,constant: -((((55/667) * screenSize.height) * 16) / 55)).isActive = true
            $0.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
            $0.widthAnchor.constraint(equalToConstant: (300/375) * screenSize.width).isActive = true
            $0.heightAnchor.constraint(equalToConstant: (55/667) * screenSize.height).isActive = true
        }
        studyIntroduceView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: studyTitleTextField.bottomAnchor,constant: Terminal.convertHeigt(value: 23)).isActive = true
            $0.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: Terminal.convertWidth(value: 15) ).isActive = true
            $0.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: Terminal.convertWidth(value: -15) ).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeigt(value: 141)).isActive = true
        }
        SNSInputView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: studyIntroduceView.bottomAnchor,constant: Terminal.convertHeigt(value: 23)).isActive = true
            $0.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: Terminal.convertWidth(value: 15) ).isActive = true
            $0.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: Terminal.convertWidth(value: -15) ).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeigt(value: 141)).isActive = true
        }
        studyInfoView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: SNSInputView.bottomAnchor,constant: Terminal.convertHeigt(value: 23)).isActive = true
            $0.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: Terminal.convertWidth(value: 15) ).isActive = true
            $0.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: Terminal.convertWidth(value: -15) ).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeigt(value: 141)).isActive = true
        }
        locationView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: studyInfoView.bottomAnchor,constant: Terminal.convertHeigt(value: 23)).isActive = true
            $0.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: Terminal.convertWidth(value: 15) ).isActive = true
            $0.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: Terminal.convertWidth(value: -15) ).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeigt(value: 141)).isActive = true
        }
        timeView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: locationView.bottomAnchor,constant: Terminal.convertHeigt(value: 23)).isActive = true
            $0.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: Terminal.convertWidth(value: -15) ).isActive = true
            $0.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: Terminal.convertWidth(value: 15) ).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeigt(value: 100)).isActive = true
        }
        button.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: timeView.bottomAnchor, constant: Terminal.convertHeigt(value: 23)).isActive = true
            $0.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: Terminal.convertWidth(value: -15) ).isActive = true
            $0.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: Terminal.convertWidth(value: 15) ).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeigt(value: 50)).isActive = true
            $0.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        }
    }
    
    func setDelegate(completion: @escaping () -> Void) {
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
        
        SNSInputView.notion.textField.debounce(delay: 1) { [weak self] text in
            //첫 로드 시 한번 실행되는 거는 분기처리를 해주자 text.isEmpty 등등으로 해결볼 수 있을 듯
            self!.presenter?.notionInputFinish(id: text ?? "")
            if self!.SNSInputView.notion.textField.text == "" {
                self!.SNSInputView.notion.textField.layer.borderColor = .none
            } else {
                self!.SNSInputView.notion.textField.layer.borderColor = UIColor.blue.cgColor
            }
        }
        SNSInputView.evernote.textField.debounce(delay: 1) { [weak self] text in
            //첫 로드 시 한번 실행되는 거는 분기처리를 해주자 text.isEmpty 등등으로 해결볼 수 있을 듯
            self!.presenter?.everNoteInputFinish(url: text ?? "")
            if self!.SNSInputView.evernote.textField.text == "" {
                self!.SNSInputView.evernote.textField.layer.borderColor = .none
            } else {
                self!.SNSInputView.evernote.textField.layer.borderColor = UIColor.blue.cgColor
            }
        }
        SNSInputView.web.textField.debounce(delay: 1) { [weak self] text in
            //첫 로드 시 한번 실행되는 거는 분기처리를 해주자 text.isEmpty 등등으로 해결볼 수 있을 듯
            self!.presenter?.URLInputFinish(url: text ?? "")
            if self!.SNSInputView.web.textField.text == "" {
                self!.SNSInputView.web.textField.layer.borderColor = .none
            } else {
                self!.SNSInputView.web.textField.layer.borderColor = UIColor.blue.cgColor
            }
        }
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
    @objc func didLocationViewClicked() {
        //SelectLocationView를 띄우는 게 맞습니다.
        presenter?.clickLocationView(currentView: self)
    }
    func openLibrary() {
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    func openCamera() {
        //시뮬에서 앱죽는거 에러처리 해야함
        picker.sourceType = .camera
        present(picker, animated: true, completion: nil)
    }
}

extension CreateStudyView: CreateStudyViewProtocols {
    func viewToTop(distance: CGFloat) {
        UIView.animate(withDuration: 0.1) {
            self.scrollView.contentOffset.y += distance
            
        } completion: { _ in
            self.textViewTapFlag = false
            if self.textViewTapFlag == false {
                self.clickedView?.becomeFirstResponder()
            }
            
        }
        
    }
    
    func viewToBottom(distance: CGFloat) {
        UIView.animate(withDuration: 0.1) {
            self.scrollView.contentOffset.y += distance
            
        } completion: { _ in
            self.textViewTapFlag = false
            if self.textViewTapFlag == false {
                self.clickedView?.becomeFirstResponder()
            }
            
        }
        
    }
    func viewTapFlagToggle() {
        textViewTapFlag = false
    }
    
    func setView() {
        attribute()
        layout()
        setDelegate(completion: {
            LoadingRainbowCat.hide {
//
            }
        })
    }
    func loading() {
        LoadingRainbowCat.show()
    }
    func getBackgroundImage() {
        print("getBackgroundImage")
    }
    func setBackgroundImage() {
        print("setVackgroundImage")
    }
    func showLoadingToNotionInput() {
        LoadingRainbowCat.show()
    }
    func showLoadingToEvernoteInput() {
        LoadingRainbowCat.show()
    }
    func showLoadingToWebInput() {
        LoadingRainbowCat.show()
    }
    func hideLoadingToNotionInput() {
        LoadingRainbowCat.hide(completion: {
//
        })
    }
    func hideLoadingToEvernoteInput() {
        LoadingRainbowCat.hide(completion: {
//
        })
    }
    func hideLoadingToWebInput() {
        LoadingRainbowCat.hide(completion: {
//
        })
    }
    func notionValid() {
        LoadingRainbowCat.hide(completion: {
//
        })
    }
    func evernoteValid() {
        LoadingRainbowCat.hide(completion: {
//
        })
    }
    func webValid() {
        LoadingRainbowCat.hide(completion: {
//
        })
    }
    func notionInvalid() {
        LoadingRainbowCat.hide(completion: {
//
        })
    }
    func evernoteInvalid() {
        LoadingRainbowCat.hide(completion: {
//
        })
    }
    func webInvalid() {
        LoadingRainbowCat.hide(completion: {
//
        })
    }
    @objc func didClickButton() {
        //하드로 넣어주고 추후에 손을 봅시다.
        var tempTitle = ""
        if state == .edit {
            tempTitle =  studyTitleTextField.text == study?.title ? "same" : "notSame"
            
            if let currentLocation = study?.location {
                selectedLocation = StudyDetailLocationPost(address: currentLocation.addressName,
                                                           lat: Double(currentLocation.latitude)!,
                                                           lng: Double(currentLocation.longitude)!,
                                                           detailAddress: nil,
                                                           placeName: nil,
                                                           category: nil,
                                                           sido: nil,
                                                           sigungu: nil)
                if let detailAddress = study?.location.addressName {
                    selectedLocation?.detailAddress = detailAddress
                }
                if let placeName = study?.location.placeName {
                    selectedLocation?.placeName = placeName
                }
                
            }
        } else {
            tempTitle = studyTitleTextField.text ?? ""
        }
        studyDetailPost = StudyDetailPost(category: selectedCategory!,
                                          title: tempTitle,
                                          introduce: studyIntroduceView.textView.text,
                                          progress: studyInfoView.textView.text,
                                          studyTime: timeView.detailTime.text ?? "",
                                          snsWeb: SNSInputView.web.textField.text,
                                          snsNotion: SNSInputView.notion.textField.text,
                                          snsEvernote: SNSInputView.evernote.textField.text,
                                          image: mainImageView.image!,
                                          location: selectedLocation!)
        presenter?.clickCompleteButton(study: studyDetailPost!, state: state!, studyID: study?.id ?? nil)
    }
    func studyInfoInvalid(message: String) {
        LoadingRainbowCat.hide() {
            print("뷰에서 찍은 겁니다~~ \(message)")
        }
    }
    func studyInfoValid(message: String) {
        LoadingRainbowCat.hide() {
            switch self.state {
            case .create:
                self.navigationController?.popViewController(animated: true)
                break
            case .edit:
                self.dismiss(animated: true) { [self] in
                    ((parentView as! MyStudyDetailViewProtocol).VCArr[1] as! StudyDetailViewProtocol).presenter?.showStudyListDetail(studyID: String(study!.id))
                }
                break
            case .none:
                break
            //                <#code#>
            }
        }
    }
}

extension CreateStudyView:  UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            mainImageView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
}

extension CreateStudyView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textViewTapFlag = true
        clickedView = textField
        presenter?.viewDidTap(textView: textField, viewMinY: CGFloat(currentScrollViewMinY), viewMaxY: CGFloat(currentScrollViewMaxY))
    }
}

extension CreateStudyView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textViewTapFlag = true
        clickedView = textView
        presenter?.viewDidTap(textView: clickedView!, viewMinY: CGFloat(currentScrollViewMinY), viewMaxY: CGFloat(currentScrollViewMaxY))
    }
}

extension CreateStudyView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if textViewTapFlag == false {
            view.endEditing(true)
        }
        currentScrollViewMinY = scrollView.contentOffset.y
        currentScrollViewMaxY = (scrollView.contentOffset.y + scrollView.frame.height) - keyboardHeight
    }
}

extension CreateStudyView: selectLocationDelegate {
    func passLocation(location: StudyDetailLocationPost) {
        selectedLocation = location
        locationView.address.text = "\(location.address)"
        guard let detail = location.detailAddress else { return }
        locationView.detailAddress.text = detail
    }
}

extension CreateStudyView: KeyboardManagerDelegate {
    func keyboardWillChangeFrame(endFrame: CGRect?, duration: TimeInterval, animationCurve: UIView.AnimationOptions) {
//        <#code#>
    }
}
