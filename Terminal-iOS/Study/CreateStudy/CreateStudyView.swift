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
    var studyOverviewUIView: StudyOverViewUIView?
//    var SNSUIView: SNSInputUIView?
    
    var notion = SNSInputItem(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    var textField = UITextField(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    var testView = TextFieldTestView(frame: CGRect(x: 0, y: 0, width: 100, height: 200))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    func attribute() {
        view.do {
            $0.backgroundColor = UIColor(named: "background")
        }
        scrollView.do {
            $0.backgroundColor = UIColor(named: "background")
        }
        imageView.do {
            $0.image = #imageLiteral(resourceName: "swiftBackground")
        }
        studyTitleTextField.do {
            $0.placeholder = "스터디 이름"
            $0.backgroundColor = .white
            $0.textAlignment = .center
            $0.textColor = .black
        }
        studyOverviewUIView = StudyOverViewUIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0),category: seletedCategory!)
        studyOverviewUIView?.do {
            $0.backgroundColor = UIColor(named: "background")
        }
        notion.do {
            $0.textField.backgroundColor = .red
        }
        textField.do {
        //            $0.frame = CGRect(x: 0, y: 0, width: 40, height: 20)
                    $0.text = "test"
        //            $0.isUserInteractionEnabled = false
                }
//        SNSUIView = SNSInputUIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
//        SNSUIView!.do {
//            $0.backgroundColor = .gray
//        }
        testView.do {
            $0.backgroundColor = .green
        }
        scrollView.addSubview(testView)
        testView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: textField.safeAreaLayoutGuide.bottomAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        }
    }
    
    func layout() {
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(studyTitleTextField)
        scrollView.addSubview(studyOverviewUIView!)
//        scrollView.addSubview(SNSUIView!)
        scrollView.addSubview(notion)
        scrollView.addSubview(textField)
        scrollView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
            $0.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor).isActive = true
            $0.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
            $0.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
            $0.contentSize = CGSize(width: screenSize.width, height: 2000)
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
        studyOverviewUIView!.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -(18/375) * screenSize.width ).isActive = true
            $0.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: (18/375) * screenSize.width ).isActive = true

            $0.topAnchor.constraint(equalTo: studyTitleTextField.bottomAnchor, constant: 100).isActive = true
//            $0.bottomAnchor.constraint(equalTo: studyOverviewUIView!.textView.bottomAnchor, constant: 10).isActive = true
            $0.bottomAnchor.constraint(equalTo: studyOverviewUIView!.textView.bottomAnchor, constant: 10).isActive = true
        }
//        SNSUIView!.do {
//            $0.translatesAutoresizingMaskIntoConstraints = false
//            $0.trailingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.trailingAnchor, constant: -(18/375) * screenSize.width ).isActive = true
//            $0.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: (18/375) * screenSize.width ).isActive = true
//            $0.topAnchor.constraint(equalTo: (studyOverviewUIView?.safeAreaLayoutGuide.bottomAnchor)!, constant: 10).isActive = true
//            $0.bottomAnchor.constraint(equalTo: (SNSUIView?.web.bottomAnchor)!, constant: 10).isActive = true
//        }
        notion.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: (studyOverviewUIView?.safeAreaLayoutGuide.bottomAnchor)!, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        }
        textField.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: notion.safeAreaLayoutGuide.bottomAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        }
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
