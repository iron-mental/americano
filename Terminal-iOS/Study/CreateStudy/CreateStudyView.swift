//
//  NewCreateStudyView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/19.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

final class CreateStudyView: BaseEditableStudyDetailView {
    var presenter: CreateStudyPresenterProtocol?
    var study: StudyDetail?
    var parentView: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        hideLoading()
    }
    
    override func attribute() {
        super.attribute()
        self.do {
            $0.title = "스터디 만들기"
        }
        self.completeButton.do {
            $0.addTarget(self, action: #selector(completeButtonDidTap), for: .touchUpInside)
        }
        self.accessoryCompleteButton.do {
            $0.addTarget(self, action: #selector(completeButtonDidTap), for: .touchUpInside)
        }
    }

    override func didLocationViewClicked() {
        presenter?.clickLocationView()
    }
    
    @objc func completeButtonDidTap() {
        self.selectedLocation?.detailAddress = self.locationView.detailAddress.text
        self.studyDetailPost = StudyDetailPost(category: self.selectedCategory ?? "",
                                               title: self.studyTitleTextField.text!,
                                               introduce: self.studyIntroduceView.textView.text!,
                                               progress: self.studyInfoView.textView.text!,
                                               studyTime: self.timeView.detailTime.text!,
                                               snsWeb: self.SNSInputView.web.textField.text!,
                                               snsNotion: self.SNSInputView.notion.textField.text!,
                                               snsEvernote: self.SNSInputView.evernote.textField.text!,
                                               image: self.mainImageView.image,
                                               location: self.selectedLocation ?? nil)
        
        presenter?.clickCompleteButton(study: studyDetailPost!, studyID: study?.id ?? nil)
        self.resetInputTextLayer()
    }
}

extension CreateStudyView: CreateStudyViewProtocol {
    func showLoading() {
        LoadingRainbowCat.show(caller: self)
    }
    func hideLoading() {
        LoadingRainbowCat.hide(caller: self)
    }
    func setView() {
    }
    
    func getBackgroundImage() {
    }
    
    func setBackgroundImage() {
    }
    
    func studyInfoInvalid(label: String? = nil, message: String) {
        showToast(controller: self, message: message, seconds: 1) {
            if let label = label {
                switch label {
                case "title":
                    self.studyTitleTextField.becomeFirstResponder()
                    self.studyTitleTextField.layer.borderWidth = 0.4
                    self.studyTitleTextField.layer.borderColor = UIColor.systemRed.cgColor
                case "introduce":
                    self.studyIntroduceView.textView.becomeFirstResponder()
                    self.studyIntroduceView.textView.layer.borderWidth = 0.4
                    self.studyIntroduceView.textView.layer.borderColor = UIColor.systemRed.cgColor
                case "progress":
                    self.studyInfoView.textView.becomeFirstResponder()
                    self.studyInfoView.textView.layer.borderWidth = 0.4
                    self.studyInfoView.textView.layer.borderColor = UIColor.systemRed.cgColor
                case "study_time":
                    self.timeView.detailTime.becomeFirstResponder()
                    self.timeView.detailTime.layer.borderWidth = 0.4
                    self.timeView.detailTime.layer.borderColor = UIColor.systemRed.cgColor
                case "locaion_detail":
                    self.presenter?.clickLocationView()
                case "sns_notion":
                    self.SNSInputView.notion.textField.becomeFirstResponder()
                    self.SNSInputView.notion.textField.layer.borderWidth = 0.4
                    self.SNSInputView.notion.textField.layer.borderColor = UIColor.systemRed.cgColor
                case "sns_evernote":
                    self.SNSInputView.evernote.textField.becomeFirstResponder()
                    self.SNSInputView.evernote.textField.layer.borderWidth = 0.4
                    self.SNSInputView.evernote.textField.layer.borderColor = UIColor.systemRed.cgColor
                case "sns_web":
                    self.SNSInputView.web.textField.becomeFirstResponder()
                    self.SNSInputView.web.textField.layer.borderWidth = 0.4
                    self.SNSInputView.web.textField.layer.borderColor = UIColor.systemRed.cgColor
                default:
                    break
                }
            }
        }
    }
    
    func studyInfoValid(studyID: Int, message: String) {
        showToast(controller: self, message: message, seconds: 1) {
            if let rootViewController = self.navigationController?.parent as? ViewController {
                rootViewController.selectedIndex = 1
                if let myStudyMainView = rootViewController.myStudyViewController as? MyStudyMainViewProtocol {
                    myStudyMainView.presenter?.viewDidLoad()
                }
            }
            self.navigationController?.viewControllers.forEach {
                if let popPoint = $0 as? StudyCategoryViewProtocol {
                    if let popViewController = popPoint as? UIViewController {
                        self.navigationController?.popToViewController(popViewController, animated: true)
                    }
                }
            }
        }
    }
    
    func showError(message: String) {
        showToast(controller: self, message: message, seconds: 1)
    }
}
