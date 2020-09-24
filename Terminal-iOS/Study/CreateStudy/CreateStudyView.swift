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
    var selectedCategory: String?
    let picker = UIImagePickerController()
    var backgroundView = UIView()
    let scrollView = UIScrollView()
    let imageView = UIImageView()
    let studyTitleTextField = UITextField()
    var seletedCategory: String?
    var studyOverviewView = StudyOverViewUIView(frame: CGRect(x: 0, y: 0, width: (121/667) * UIScreen.main.bounds.width, height: (352/375) * UIScreen.main.bounds.height))
    var SNSInputView = SNSInputUIVIew(frame: CGRect(x: 0, y: 0, width: (121/667) * UIScreen.main.bounds.width, height: (352/375) * UIScreen.main.bounds.height))
    var locationView = LocationUIVIew()
    var timeView = TimeUIView()
    var button = UIButton()
    var tapGestureRecognizer = UITapGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidLoad()
        studyTitleTextField.delegate = self
        SNSInputView.evernote.textField.delegate = self
        picker.delegate = self
        
        SNSInputView.evernote.textField.debounce(delay: 1) { text in
            //첫 로드 시 한번 실행되는 거는 분기처리를 해주자 text.isEmpty 등등으로 해결볼 수 있을 듯
            print(text)
        }
    }
    
    func attribute() {
        view.do {
            $0.backgroundColor = UIColor(named: "background")
        }
        scrollView.do {
            $0.backgroundColor = UIColor(named: "background")
        }
        backgroundView.do {
            $0.backgroundColor = .brown
        }
        imageView.do {
            tapGestureRecognizer = UITapGestureRecognizer(target:self, action: #selector (didImageViewClicked))
            $0.image = #imageLiteral(resourceName: "swiftBackground")
            $0.isUserInteractionEnabled = true
            $0.addGestureRecognizer(tapGestureRecognizer)
        }
        studyTitleTextField.do {
            $0.placeholder = "스터디 이름"
            $0.backgroundColor = .white
            $0.textAlignment = .center
            $0.textColor = .black
        }
        studyOverviewView.do {
            $0.backgroundColor = .cyan
            $0.textView.backgroundColor = .blue
        }
        SNSInputView.do {
            $0.backgroundColor = .orange
        }
        //        locationView.do {
        //            $0.backgroundColor = .red
        //            $0.detailAddress.backgroundColor = .yellow
        //        }
        //        timeView.do {
        //            $0.backgroundColor = .blue
        //            $0.detailTime.backgroundColor = .brown
        //        }
        //        button.do {
        //            $0.setTitle("완료", for: .normal)
        //            $0.backgroundColor = UIColor(named: "key")
        //        }
    }
    
    func layout() {
        view.addSubview(scrollView)
        scrollView.addSubview(backgroundView)
        backgroundView.addSubview(imageView)
        backgroundView.addSubview(studyTitleTextField)
        backgroundView.addSubview(studyOverviewView)
        backgroundView.addSubview(SNSInputView)
        //        scrollView.addSubview(locationView)
        //        scrollView.addSubview(timeView)
        //        scrollView.addSubview(button)
        
        scrollView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.leftAnchor.constraint(equalTo: view.leftAnchor, constant:0).isActive = true
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            $0.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
            $0.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        }
        backgroundView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
            $0.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
            $0.heightAnchor.constraint(equalTo: scrollView.heightAnchor,constant: 3000).isActive = true
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
        studyOverviewView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: studyTitleTextField.bottomAnchor,constant: (18/667) * screenSize.height).isActive = true
            $0.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: (18/375) * screenSize.width ).isActive = true
            $0.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -(18/375) * screenSize.width ).isActive = true
            $0.bottomAnchor.constraint(equalTo: studyOverviewView.textView.bottomAnchor).isActive = true
        }
        SNSInputView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: studyOverviewView.bottomAnchor,constant: (10/667) * screenSize.height).isActive = true
            $0.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -(18/375) * screenSize.width ).isActive = true
            $0.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: (18/375) * screenSize.width ).isActive = true
            $0.bottomAnchor.constraint(equalTo: SNSInputView.web.bottomAnchor).isActive = true
        }
        //        locationView.do {
        //            $0.translatesAutoresizingMaskIntoConstraints = false
        //            $0.topAnchor.constraint(equalTo: SNSInputView.bottomAnchor).isActive = true
        //            $0.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -(18/375) * screenSize.width ).isActive = true
        //            $0.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: (18/375) * screenSize.width ).isActive = true
        //            $0.bottomAnchor.constraint(equalTo: locationView.detailAddress.bottomAnchor).isActive = true
        //        }
        //        timeView.do {
        //            $0.translatesAutoresizingMaskIntoConstraints = false
        //            $0.topAnchor.constraint(equalTo: locationView.bottomAnchor).isActive = true
        //            $0.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -(18/375) * screenSize.width ).isActive = true
        //            $0.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: (18/375) * screenSize.width ).isActive = true
        //            $0.bottomAnchor.constraint(equalTo: timeView.detailTime.bottomAnchor).isActive = true
        //        }
        //        button.do {
        //            $0.translatesAutoresizingMaskIntoConstraints = false
        //            $0.topAnchor.constraint(equalTo: timeView.bottomAnchor, constant: 30).isActive = true
        //            $0.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        //            $0.widthAnchor.constraint(equalToConstant: 250).isActive = true
        //            $0.heightAnchor.constraint(equalToConstant: 150).isActive = true
        //        }
        
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
    }
    
    func getBackgroundImage() {
        print("getBackgroundImage")
    }
    func setBackgroundImage() {
        print("setVackgroundImage")
    }
}

extension CreateStudyView:  UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            imageView.image = image
            print(info)
        }
        dismiss(animated: true, completion: nil)
    }
}

extension CreateStudyView: UITextFieldDelegate {
    
}
