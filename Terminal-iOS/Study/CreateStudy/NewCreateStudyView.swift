//
//  NewCreateStudyView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/19.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

class NewCreateStudyView: BaseEditableStudyDetailView {
    var presenter: CreateStudyPresenterProtocols?
    var state: WriteStudyViewState?
    var study: StudyDetail?
    var parentView: UIViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension NewCreateStudyView: CreateStudyViewProtocols {
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
        presenter?.clickCompleteButton(study: studyDetailPost!, state: state!, studyID: study?.id ?? nil)
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
    
    func showLoadingToNotionInput() {
//        <#code#>
    }
    
    func showLoadingToEvernoteInput() {
//        <#code#>
    }
    
    func showLoadingToWebInput() {
//        <#code#>
    }
    
    func hideLoadingToNotionInput() {
//        <#code#>
    }
    
    func hideLoadingToEvernoteInput() {
//        <#code#>
    }
    
    func hideLoadingToWebInput() {
//        <#code#>
    }
    
    func notionValid() {
//        <#code#>
    }
    
    func evernoteValid() {
//        <#code#>
    }
    
    func webValid() {
//        <#code#>
    }
    
    func notionInvalid() {
//        <#code#>
    }
    
    func evernoteInvalid() {
//        <#code#>
    }
    
    func webInvalid() {
//        <#code#>
    }
    
    func studyInfoInvalid(message: String) {
//        <#code#>
    }
    
    func studyInfoValid(message: String) {
//        <#code#>
    }
    
    
}
