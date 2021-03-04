//
//  ModifyStudyView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/19.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

class ModifyStudyView: BaseEditableStudyDetailView {
    var presenter: ModifyStudyPresenterProtocol?
    var study: StudyDetail?
    
    override func attribute() {
        super.attribute()
        
        mainImageView.do {
            guard let url = study?.image else { return }
            $0.kf.setImage(with: URL(string: url),
                           options: [.requestModifier(RequestToken.token())])
        }
        self.do {
            $0.title = "스터디 수정"
        }
        studyTitleTextField.do {
            $0.text = study?.title
        }
        studyIntroduceView.do {
            $0.textView.text = study?.introduce
        }
        SNSInputView.do {
            $0.notion.textField.text = study?.snsNotion ?? ""
            $0.evernote.textField.text = study?.snsEvernote ?? ""
            $0.web.textField.text = study?.snsWeb ?? ""
        }
        studyInfoView.do {
            $0.textView.text = study?.progress
        }
        locationView.do {
            $0.address.text = study?.location.addressName
            $0.detailAddress.text = study?.location.locationDetail ?? ""
        }
        timeView.do {
            $0.detailTime.text = study?.studyTime
        }
        completeButton.do {
            $0.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
        }
        accessoryCompleteButton.do {
            $0.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
        }
    }
    
    override func didLocationViewClicked() {
        presenter?.clickLocationView()
    }
    
    @objc func buttonDidTap() {
        self.selectedLocation?.detailAddress = self.locationView.detailAddress.text
        
        self.studyDetailPost = StudyDetailPost(category: self.study!.category,
                                               title: self.studyTitleTextField.text ?? "",
                                               introduce: self.studyIntroduceView.textView.text ?? "",
                                               progress: self.studyInfoView.textView.text ?? "",
                                               studyTime: self.timeView.detailTime.text ?? "",
                                               snsWeb: self.SNSInputView.web.textField.text ?? "",
                                               snsNotion: self.SNSInputView.notion.textField.text ?? "",
                                               snsEvernote: self.SNSInputView.evernote.textField.text ?? "",
                                               image: self.mainImageView.image,
                                               location: self.selectedLocation ?? nil)
        
        guard let id = study?.id else { return }
        presenter?.completButtonDidTap(studyID: id, study: self.studyDetailPost!)
        if let myStudyDetailView = self.navigationController?.viewControllers[1] as? MyStudyDetailView {
            myStudyDetailView.viewState = .StudyDetail
        }
    }
}

extension ModifyStudyView: ModifyStudyViewProtocol {    
    func showResult(message: String) {
        showToast(controller: self, message: message, seconds: 1) {
            self.navigationController?.viewControllers.forEach {
                if let myStudyDetailView = $0 as? MyStudyDetailView,
                   let studyDetailView = myStudyDetailView.vcArr[1] as? StudyDetailViewProtocol {
                    if let id = self.study?.id {
                        studyDetailView.presenter?.showStudyListDetail(studyID: "\(id)")
                    }
                }
                if let myStudyMainView = $0 as? MyStudyMainViewProtocol {
                    myStudyMainView.presenter?.viewDidLoad()
                }
            }
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func showError(label: String? = nil, message: String) {
        showToast(controller: self, message: message, seconds: 1) {
            if let label = label {
                switch label {
                case "title":
                    self.studyTitleTextField.becomeFirstResponder()
                case "introduce":
                    self.studyIntroduceView.textView.becomeFirstResponder()
                case "progress":
                    self.studyInfoView.textView.becomeFirstResponder()
                case "study_time":
                    self.timeView.detailTime.becomeFirstResponder()
                case "locaion_detail":
                    self.locationView.detailAddress.becomeFirstResponder()
                case "sns_notion":
                    self.SNSInputView.notion.textField.becomeFirstResponder()
                case "sns_evernote":
                    self.SNSInputView.evernote.textField.becomeFirstResponder()
                case "sns_web":
                    self.SNSInputView.web.textField.becomeFirstResponder()
                default:
                    break
                }
            }
        }
    }
    func showLoading() {
        LoadingRainbowCat.show(caller: self)
    }
    
    func hideLoading() {
        LoadingRainbowCat.hide(caller: self)
    }
}
