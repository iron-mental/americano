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
    var parentView: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func attribute() {
        super.attribute()
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
        button.do {
            $0.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
        }
        accessoryCompletButton.do {
            $0.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
        }
    }
    
    override func didLocationViewClicked() {
        presenter?.clickLocationView(currentView: self)
    }
    
    @objc func buttonDidTap() {
        selectedLocation?.detailAddress = locationView.detailAddress.text
        
        studyDetailPost = StudyDetailPost(category: study!.category,
                                          title: studyTitleTextField.text ?? "",
                                          introduce: studyIntroduceView.textView.text ?? "",
                                          progress: studyInfoView.textView.text ?? "",
                                          studyTime: timeView.detailTime.text ?? "",
                                          snsWeb: SNSInputView.web.textField.text ?? "",
                                          snsNotion: SNSInputView.notion.textField.text ?? "",
                                          snsEvernote: SNSInputView.evernote.textField.text ?? "",
                                          image: mainImageView.image,
                                          location: selectedLocation ?? nil)
        
        guard let id = study?.id else { return }
        presenter?.completButtonDidTap(studyID: id, study: studyDetailPost!)
        
    }
}

extension ModifyStudyView: ModifyStudyViewProtocol {
    func showResult(message: String) {
        showToast(controller: self, message: message, seconds: 1) {
            self.navigationController?.popViewController(animated: true, completion: {
                if let myStudyDetailView = (self.navigationController?.viewControllers[1] as? MyStudyDetailView) {
                    if let studyDetailView = myStudyDetailView.VCArr[1] as? StudyDetailViewProtocol {
                        if let id = self.study?.id {
                            studyDetailView.presenter?.showStudyListDetail(studyID: "\(id)")
                        }
                    }
                }
            })
        }
    }
    
    func showError() {
        showToast(controller: self, message: "수정에 실패하였습니다.", seconds: 1)
    }
}
