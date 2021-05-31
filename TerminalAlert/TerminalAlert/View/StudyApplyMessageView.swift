//
//  StudyApplyMessageView.swift
//  TerminalAlert
//
//  Created by once on 2021/05/31.
//

import UIKit

enum StudyApplyMessageType {
  case apply
  case modify
}

class StudyApplyMessageView: AlertBaseUIView {
  var type: StudyApplyMessageType = .apply
  var applyTitleLabel = UILabel()
  var applyGuideLabel = UILabel()
  var editMessageTextView = UITextView()
  
  init(type: StudyApplyMessageType) {
    super.init()
    self.type = type
    super.attribute()
    attribute()
    layout()
  }
  
  override func attribute() {
    super.attribute()
    
      applyTitleLabel.font = UIFont.systemFont(ofSize: 15)
      applyTitleLabel.text = type == .apply ? "스터디 신청하기" : "신청 메세지 수정하기"
    
      applyGuideLabel.font = UIFont.systemFont(ofSize: 13)
      applyGuideLabel.text = type == .apply ? "가입 인사를 작성해보세요" : "수정할 메세지를 작성하세요"
    
      editMessageTextView.font = UIFont.systemFont(ofSize: 10)
      editMessageTextView.delegate = self
      editMessageTextView.backgroundColor = .systemGray6
      editMessageTextView.layer.cornerRadius = 6
      editMessageTextView.layer.masksToBounds = true
      editMessageTextView.text = "ex) 열심히 공부할 자신 있습니다!!"
      editMessageTextView.textColor = .systemGray2
  }
  
  override func layout() {
    super.layout()
    
    [bottomBar, applyTitleLabel, applyGuideLabel, editMessageTextView].forEach { addSubview($0) }
    
    applyTitleLabel.translatesAutoresizingMaskIntoConstraints = false
    applyTitleLabel.topAnchor.constraint(equalTo: bottomBar.topAnchor, constant: 8).isActive = true
    applyTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    
    applyGuideLabel.translatesAutoresizingMaskIntoConstraints = false
    applyGuideLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: AlertBaseUIView.convertWidth(value: 20)).isActive = true
    applyGuideLabel.topAnchor.constraint(equalTo: applyTitleLabel.bottomAnchor, constant: 16).isActive = true
    
    editMessageTextView.translatesAutoresizingMaskIntoConstraints = false
    editMessageTextView.topAnchor.constraint(equalTo: applyGuideLabel.bottomAnchor, constant: AlertBaseUIView.convertHeight(value: 15)).isActive = true
    editMessageTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: AlertBaseUIView.convertWidth(value: 15)).isActive = true
    editMessageTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -AlertBaseUIView.convertWidth(value: 15)).isActive = true
    editMessageTextView.bottomAnchor.constraint(equalTo: completeButton.topAnchor, constant: -AlertBaseUIView.convertHeight(value: 15)).isActive = true
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension StudyApplyMessageView: UITextViewDelegate {
  func textViewDidBeginEditing(_ textView: UITextView) {
    textView.font = UIFont.systemFont(ofSize: 12)
    textView.textColor = .white
    textView.text = ""
  }
}
