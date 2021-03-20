//
//  CareerModifyView.swift
//  Terminal-iOS
//
//  Created by once on 2020/12/22.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class CareerModifyView: UIViewController {
    var presenter: CareerModifyPresenterProtocol?
    var careerTitle: String? {
        didSet {
            if let title = self.careerTitle {
                self.careerTitleModify.text = title
            }
        }
    }
    var careerContents: String? {
        didSet {
            if let contents = self.careerContents {
                self.careerDescriptModify.text = contents
            }
        }
    }
    
    lazy var careerLabel = UILabel()
    lazy var careerTitleModify = UITextField()
    lazy var careerDescriptModify = UITextView()
    lazy var completeButton = UIButton()
    var accessoryCompleteButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
    
    func attribute() {
        self.do {
            $0.hideKeyboardWhenTappedAround()
            $0.view.backgroundColor = .appColor(.terminalBackground)
            $0.title = "경력 수정"
        }
        
        self.careerLabel.do {
            $0.text = "경력"
            $0.textColor = .white
        }
        
        self.careerTitleModify.do {
            $0.placeholder = "타이틀"
            $0.addLeftPadding(padding: 10)
            $0.backgroundColor = .red
            $0.textColor = .white
            $0.dynamicFont(fontSize: 16, weight: .bold)
            $0.textAlignment = .left
            $0.layer.cornerRadius = 10
            $0.layer.borderColor = UIColor.gray.cgColor
            $0.layer.borderWidth = 0.1
            $0.backgroundColor = UIColor.appColor(.cellBackground)
            $0.inputAccessoryView = accessoryCompleteButton
        }
        
        self.careerDescriptModify.do {
            $0.backgroundColor = .red
            $0.textColor = UIColor.appColor(.profileTextColor)
            $0.dynamicFont(size: 14, weight: .regular)
            $0.sizeToFit()
            $0.textContainer.lineFragmentPadding = 0
            $0.textContainerInset = .zero
            $0.layer.masksToBounds = true
            $0.isScrollEnabled = false
            $0.layer.cornerRadius = 10
            $0.layer.borderColor = UIColor.gray.cgColor
            $0.layer.borderWidth = 0.1
            $0.backgroundColor = UIColor.appColor(.cellBackground)
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
            $0.backgroundColor = UIColor.appColor(.mainColor)
            $0.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 45)
            $0.addTarget(self, action: #selector(completeModify), for: .touchUpInside)
        }
    }
    
    func layout() {
        [careerLabel, careerTitleModify, careerDescriptModify, completeButton].forEach { self.view.addSubview($0) }
        self.careerLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 18).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 25).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -25).isActive = true
        }
        
        self.careerTitleModify.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: careerLabel.bottomAnchor, constant: 4).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 25).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -25).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 40).isActive = true
        }
        
        self.careerDescriptModify.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: careerTitleModify.bottomAnchor, constant: 4).isActive = true
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
    }
    
    @objc func completeModify() {
        let title = careerTitleModify.text!
        let contents = careerDescriptModify.text!
        showLoading()
        presenter?.completeModify(title: title, contents: contents)
        self.careerTitleModify.layer.borderWidth = 0.1
        self.careerTitleModify.layer.borderColor = UIColor.gray.cgColor
        self.careerDescriptModify.layer.borderWidth = 0.1
        self.careerDescriptModify.layer.borderColor = UIColor.gray.cgColor
    }
}

extension CareerModifyView: CareerModifyViewProtocol {
    func modifyResultHandle(result: Bool, message: String) {
        if result {
            let parent = self.navigationController?.viewControllers[1] as? ProfileDetailView
            self.navigationController?.popViewController(animated: true) {
                parent?.showToast(controller: parent!, message: "경력 수정 완료", seconds: 1)
                parent?.presenter?.viewDidLoad()
            }
        } else {
            let alert =  UIAlertController(title: "결과", message: message, preferredStyle: .alert)
            let okAction =  UIAlertAction(title: "확인", style: .default) { _ in }
            alert.addAction(okAction)
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
    }
    
    func showError(message: String, label: String) {
        showToast(controller: self, message: message, seconds: 1) {
            switch label {
            case "career_title":
                self.careerTitleModify.warningEffect()
            case "career_contents":
                self.careerDescriptModify.warningEffect()
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
    
    func showError(message: String) {
        showToast(controller: self, message: message, seconds: 1)
    }
}
