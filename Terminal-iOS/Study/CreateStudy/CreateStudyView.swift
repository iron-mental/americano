//
//  CreateStudyView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/15.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class CreateStudyView: UIViewController{
    var presenter: CreateStudyPresenterProtocols?
    
    let screenSize = UIScreen.main.bounds
    var selectedCategory: Category?
    let picker = UIImagePickerController()
    var backgroundView = UIView()
    let scrollView = UIScrollView()
    let imageView = UIImageView()
    let studyTitleTextField = UITextField()
    var seletedCategory: Category?
    var studyOverView = StudyOverViewUIView(frame: CGRect(x: 0, y: 0, width: (352/375) * UIScreen.main.bounds.width, height: (121/667) * UIScreen.main.bounds.height),title: "스터디 소개")
    var SNSInputView = IdInputView(frame: CGRect(x: 0, y: 0, width: (352/375) * UIScreen.main.bounds.width, height: (118/667) * UIScreen.main.bounds.height))
    var studyInfoView = StudyOverViewUIView(frame: CGRect(x: 0, y: 0, width: (352/375) * UIScreen.main.bounds.width, height: (121/667) * UIScreen.main.bounds.height),title: "스터디 진행")
    var locationView = LocationUIVIew(frame: CGRect(x: 0, y: 0, width: (352/375) * UIScreen.main.bounds.width, height: (53/667) * UIScreen.main.bounds.height))
    var timeView = TimeUIView(frame: CGRect(x: 0, y: 0, width: (352/375) * UIScreen.main.bounds.width, height: (53/667) * UIScreen.main.bounds.height))
    var button = UIButton()
    var tapGestureRecognizer = UITapGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidLoad()
    }
    
    func attribute() {
        view.do {
            $0.backgroundColor = UIColor.appColor(.testColor)
        }
        scrollView.do {
            $0.backgroundColor = UIColor.appColor(.testColor)
        }
        backgroundView.do {
            $0.backgroundColor = UIColor.appColor(.testColor)
        }
        imageView.do {
            tapGestureRecognizer = UITapGestureRecognizer(target:self, action: #selector (didImageViewClicked))
            $0.image = #imageLiteral(resourceName: "swiftBackground")
            $0.isUserInteractionEnabled = true
            $0.addGestureRecognizer(tapGestureRecognizer)
        }
        studyTitleTextField.do {
            $0.placeholder = "스터디 이름을 입력하세요"
            $0.backgroundColor = UIColor.appColor(.InputViewColor)
            $0.textAlignment = .center
            $0.textColor = .white
            $0.layer.cornerRadius = 10
        }
        studyOverView.do {
            $0.backgroundColor = UIColor.appColor(.testColor)
        }
        SNSInputView.do {
            $0.backgroundColor = UIColor.appColor(.testColor)
        }
        studyInfoView.do {
            $0.backgroundColor = UIColor.appColor(.testColor)
        }
        locationView.do {
            $0.backgroundColor = UIColor.appColor(.testColor)
        }
        timeView.do {
            $0.backgroundColor = UIColor.appColor(.testColor)
        }
        button.do {
            $0.setTitle("완료", for: .normal)
            $0.backgroundColor = UIColor(named: "key")
            $0.layer.cornerRadius = 10
        }
    }
    
    func layout() {
        view.addSubview(scrollView)
        scrollView.addSubview(backgroundView)
        backgroundView.addSubview(imageView)
        backgroundView.addSubview(studyTitleTextField)
        backgroundView.addSubview(studyOverView)
        backgroundView.addSubview(SNSInputView)
        backgroundView.addSubview(studyInfoView)
        backgroundView.addSubview(locationView)
        backgroundView.addSubview(timeView)
        backgroundView.addSubview(button)
        
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
            $0.heightAnchor.constraint(equalTo: scrollView.heightAnchor,constant: 400).isActive = true
            $0.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        }
        imageView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.widthAnchor.constraint(equalToConstant: screenSize.width).isActive = true
            $0.heightAnchor.constraint(equalToConstant: (170/667) * screenSize.height).isActive = true
            $0.topAnchor.constraint(equalTo: backgroundView.topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor).isActive = true
        }
        studyTitleTextField.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: imageView.bottomAnchor,constant: -((((55/667) * screenSize.height) * 16) / 55)).isActive = true
            $0.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
            $0.widthAnchor.constraint(equalToConstant: (300/375) * screenSize.width).isActive = true
            $0.heightAnchor.constraint(equalToConstant: (55/667) * screenSize.height).isActive = true
        }
        studyOverView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: studyTitleTextField.bottomAnchor,constant: (18/667) * screenSize.height).isActive = true
            $0.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: (18/375) * screenSize.width ).isActive = true
            $0.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -(18/375) * screenSize.width ).isActive = true
            $0.bottomAnchor.constraint(equalTo: studyOverView.textView.bottomAnchor).isActive = true
        }
        SNSInputView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: studyOverView.bottomAnchor,constant: (13/667) * screenSize.height).isActive = true
            $0.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: (18/375) * screenSize.width ).isActive = true
            $0.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -(18/375) * screenSize.width ).isActive = true
            $0.bottomAnchor.constraint(equalTo: $0.web!.bottomAnchor).isActive = true
        }
        studyInfoView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: SNSInputView.bottomAnchor, constant: (13/667) * screenSize.height).isActive = true
            $0.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: (18/375) * screenSize.width ).isActive = true
            $0.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -(18/375) * screenSize.width ).isActive = true
            $0.bottomAnchor.constraint(equalTo: $0.textView.bottomAnchor).isActive = true
        }
        locationView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: studyInfoView.bottomAnchor,constant: (13/667) * screenSize.height).isActive = true
            $0.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: (18/375) * screenSize.width ).isActive = true
            $0.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -(18/375) * screenSize.width ).isActive = true
            $0.bottomAnchor.constraint(equalTo: locationView.detailAddress.bottomAnchor).isActive = true
        }
        timeView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: locationView.bottomAnchor,constant: (13/667) * screenSize.height).isActive = true
            $0.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -(18/375) * screenSize.width ).isActive = true
            $0.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: (18/375) * screenSize.width ).isActive = true
            $0.bottomAnchor.constraint(equalTo: timeView.detailTime.bottomAnchor).isActive = true
        }
        button.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: timeView.bottomAnchor, constant: (26/667) * screenSize.height).isActive = true
            $0.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
            $0.widthAnchor.constraint(equalToConstant: (335/375) * screenSize.width).isActive = true
            $0.heightAnchor.constraint(equalToConstant: (43/667) * screenSize.height).isActive = true
        }
        
    }
    
    func setDelegate() {
        scrollView.delegate = self
        
        studyTitleTextField.delegate = self
        
        SNSInputView.notion?.textField.delegate = self
        SNSInputView.evernote?.textField.delegate = self
        SNSInputView.web?.textField.delegate = self
        
        picker.delegate = self
        
        
        SNSInputView.notion!.textField.debounce(delay: 1) { [weak self] text in
            //첫 로드 시 한번 실행되는 거는 분기처리를 해주자 text.isEmpty 등등으로 해결볼 수 있을 듯
            self!.presenter?.notionInputFinish(id: text ?? "")
        }
        SNSInputView.evernote!.textField.debounce(delay: 1) { [weak self] text in
            //첫 로드 시 한번 실행되는 거는 분기처리를 해주자 text.isEmpty 등등으로 해결볼 수 있을 듯
            self!.presenter?.everNoteInputFinish(url: text ?? "")
        }
        SNSInputView.web!.textField.debounce(delay: 1) { [weak self] text in
            //첫 로드 시 한번 실행되는 거는 분기처리를 해주자 text.isEmpty 등등으로 해결볼 수 있을 듯
            self!.presenter?.URLInputFinish(url: text ?? "")
        }
    }
    
    // FUNCTION
    
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
        //시뮬에서 앱죽는거 에러처리 해야함
        picker.sourceType = .camera
        present(picker, animated: true, completion: nil)
    }
}

extension CreateStudyView: CreateStudyViewProtocols {
    func setView() {
        attribute()
        layout()
        setDelegate()
    }
    func getBackgroundImage() {
        print("getBackgroundImage")
    }
    func setBackgroundImage() {
        print("setVackgroundImage")
    }
    func showLoadingToNotionInput() {
        print("노션 로딩중")
    }
    func showLoadingToEvernoteInput() {
        print("에버노트 로딩중")
    }
    
    func showLoadingToWebInput() {
        print("웹 로딩중")
    }
    func hideLoadingToNotionInput() {
        print("hideLoadingToNotionInput")
    }
    
    func hideLoadingToEvernoteInput() {
        print("hideLoadingToEvernoteInput")
    }
    
    func hideLoadingToWebInput() {
        print("hideLoadingToWebInput")
    }
    
    func notionValid() {
        print("notionValid")
    }
    
    func evernoteValid() {
        print("evernoteValid")
    }
    
    func webValid() {
        print("webValid")
    }
    
    func notionInvalid() {
        print("notionInvalid")
    }
    
    func evernoteInvalid() {
        print("evernoteInvalid")
    }
    
    func webInvalid() {
        print("webInvalid")
    }
    //추후에 파라미터로 스터디모델 넘겨줘야겠다
    func didClickButton() {
        presenter?.clickCompleteButton()
    }
}

extension CreateStudyView:  UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            imageView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
}

extension CreateStudyView: UITextFieldDelegate {
    
}

extension CreateStudyView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}
