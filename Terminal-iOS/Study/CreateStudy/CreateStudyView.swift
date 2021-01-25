//
//  NewCreateStudyView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/19.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

class CreateStudyView: BaseEditableStudyDetailView {
    var presenter: CreateStudyPresenterProtocol?
    var state: WriteStudyViewState?
    var study: StudyDetail?
    var parentView: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func attribute() {
        super.attribute()
        self.button.do {
            $0.addTarget(self, action: #selector(completeButtonDidTap), for: .touchUpInside)
        }
    }

    override func didLocationViewClicked() {
        presenter?.clickLocationView(currentView: self)
    }
    
    @objc func completeButtonDidTap() {
        studyDetailPost = StudyDetailPost(category: selectedCategory ?? "",
                                          title: studyTitleTextField.text!,
                                          introduce: studyIntroduceView.textView.text!,
                                          progress: studyInfoView.textView.text!,
                                          studyTime: timeView.detailTime.text!,
                                          snsWeb: SNSInputView.web.textField.text!,
                                          snsNotion: SNSInputView.notion.textField.text!,
                                          snsEvernote: SNSInputView.evernote.textField.text!,
                                          image: mainImageView.image,
                                          location: selectedLocation ?? nil)
        presenter?.clickCompleteButton(study: studyDetailPost!, studyID: study?.id ?? nil)
    }
}

extension CreateStudyView: CreateStudyViewProtocol {
    func didClickButton() {
        studyDetailPost = StudyDetailPost(category: selectedCategory!,
                                          title: studyTitleTextField.text ?? "",
                                          introduce: studyIntroduceView.textView.text ?? "",
                                          progress: studyInfoView.textView.text ?? "",
                                          studyTime: timeView.detailTime.text ?? "",
                                          snsWeb: SNSInputView.web.textField.text,
                                          snsNotion: SNSInputView.notion.textField.text,
                                          snsEvernote: SNSInputView.evernote.textField.text,
                                          image: mainImageView.image,
                                          location: selectedLocation!)
        presenter?.clickCompleteButton(study: studyDetailPost!, studyID: study?.id ?? nil)
    }
    
    func loading() {
//        <#code#>
    }
    
    func setView() {
//        <#code#>
    }
    
    func getBackgroundImage() {
//        <#code#>
    }
    
    func setBackgroundImage() {
//        <#code#>
    }
    
    func studyInfoInvalid(message: String) {
        showToast(controller: self, message: message, seconds: 1)
    }
    
    func studyInfoValid(studyID: Int, message: String) {
        showToast(controller: self, message: message, seconds: 1)
    }
}
