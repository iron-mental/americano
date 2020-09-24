//
//  CreateStudyView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/15.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class CreateStudyView: UIViewController {
    var presenter: CreateStudyPresenterProtocols?
    
    let screenSize = UIScreen.main.bounds
    var selectedCategory: String?
    
    let scrollView = UIScrollView()
    let imageView = UIImageView()
    let studyTitleTextField = UITextField()
    var seletedCategory: String?
    var studyOverviewView: StudyOverViewUIView?
    var SNSInputView = SNSInputUIVIew()
    var locationView = LocationUIVIew()
    var timeView = TimeUIView()
    var button = UIButton()
    var tapGestureRecognizer = UITapGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter?.viewDidLoad()
        
    }
    
    
    func attribute() {
        
        view.do {
            $0.backgroundColor = UIColor(named: "background")
        }
        scrollView.do {
            $0.backgroundColor = UIColor(named: "background")
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
        studyOverviewView = StudyOverViewUIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), category: seletedCategory!)
        studyOverviewView!.do {
            $0.backgroundColor = .cyan
            $0.textView.backgroundColor = .blue
        }
        SNSInputView.do {
            $0.backgroundColor = .orange
            $0.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        }
        locationView.do {
            $0.backgroundColor = .red
            $0.detailAddress.backgroundColor = .yellow
        }
        timeView.do {
            $0.backgroundColor = .blue
            $0.detailTime.backgroundColor = .brown
        }
        button.do {
            $0.setTitle("완료", for: .normal)
            $0.backgroundColor = UIColor(named: "key")
        }
    }
    
    func layout() {
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(studyTitleTextField)
        scrollView.addSubview(studyOverviewView!)
        scrollView.addSubview(SNSInputView)
        scrollView.addSubview(locationView)
        scrollView.addSubview(timeView)
        scrollView.addSubview(button)
        
        scrollView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.contentSize = CGSize(width: screenSize.width, height: 1500)
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            $0.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            $0.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            $0.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        }
        imageView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.widthAnchor.constraint(equalToConstant: screenSize.width).isActive = true
            $0.heightAnchor.constraint(equalToConstant: (170/667) * screenSize.height).isActive = true
            $0.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        }
        studyTitleTextField.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerXAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.centerXAnchor).isActive = true
            $0.widthAnchor.constraint(equalToConstant: (300/375) * screenSize.width).isActive = true
            $0.heightAnchor.constraint(equalToConstant: (55/667) * screenSize.height).isActive = true
            $0.topAnchor.constraint(equalTo: imageView.bottomAnchor,constant: -((((55/667) * screenSize.height) * 16) / 55)).isActive = true
        }
        studyOverviewView!.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -(18/375) * screenSize.width ).isActive = true
            $0.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: (18/375) * screenSize.width ).isActive = true
            $0.topAnchor.constraint(equalTo: studyTitleTextField.bottomAnchor, constant: 100).isActive = true
            $0.bottomAnchor.constraint(equalTo: (studyOverviewView?.textView.bottomAnchor)!, constant: 10).isActive = true
        }
        SNSInputView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: studyOverviewView!.safeAreaLayoutGuide.bottomAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -(18/375) * screenSize.width ).isActive = true
            $0.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: (18/375) * screenSize.width ).isActive = true
            $0.bottomAnchor.constraint(equalTo: SNSInputView.web.bottomAnchor).isActive = true
        }
        locationView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: SNSInputView.bottomAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -(18/375) * screenSize.width ).isActive = true
            $0.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: (18/375) * screenSize.width ).isActive = true
            $0.bottomAnchor.constraint(equalTo: locationView.detailAddress.bottomAnchor).isActive = true
        }
        timeView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: locationView.bottomAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -(18/375) * screenSize.width ).isActive = true
            $0.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: (18/375) * screenSize.width ).isActive = true
            $0.bottomAnchor.constraint(equalTo: timeView.detailTime.bottomAnchor).isActive = true
        }
        button.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: timeView.bottomAnchor, constant: 30).isActive = true
            $0.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 250).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 150).isActive = true
        }
    }
    
    // FUNCTION
    
    @objc func didImageViewClicked() {
        print("didImageViewClicked")
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
