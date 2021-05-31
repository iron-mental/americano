//
//  AlertReportContentView.swift
//  TerminalAlert
//
//  Created by once on 2021/05/31.
//

import UIKit

public class AlertReportContentView: AlertBaseUIView {
  public var reportTitleLabel = UILabel()
  public var editMessageTextView = UITextView()
  
  override init() {
    super.init()
    attribute()
    layout()
  }
  
  override func attribute() {
    super.attribute()
    reportTitleLabel.font = UIFont.systemFont(ofSize: 13)
    reportTitleLabel.text = "📢 신고내용을 기재해주세요."
    
    editMessageTextView.font = UIFont.systemFont(ofSize: 10)
    editMessageTextView.delegate = self
    editMessageTextView.backgroundColor = .systemGray6
    editMessageTextView.layer.cornerRadius = 6
    editMessageTextView.layer.masksToBounds = true
    editMessageTextView.text = "허위 신고 시 이용이 제한될 수 있습니다."
    editMessageTextView.textColor = .systemGray2
    
  }
  
  override func layout() {
    super.layout()
    [bottomBar, reportTitleLabel, editMessageTextView].forEach { addSubview($0) }
    
    reportTitleLabel.translatesAutoresizingMaskIntoConstraints = false
    reportTitleLabel.topAnchor.constraint(equalTo: bottomBar.topAnchor, constant: AlertBaseUIView.convertHeight(value: 20)).isActive = true
    reportTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    
    editMessageTextView.translatesAutoresizingMaskIntoConstraints = false
    editMessageTextView.topAnchor.constraint(equalTo: reportTitleLabel.bottomAnchor, constant: AlertBaseUIView.convertHeight(value: 15)).isActive = true
    editMessageTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: AlertBaseUIView.convertWidth(value: 15)).isActive = true
    editMessageTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -AlertBaseUIView.convertWidth(value: 15)).isActive = true
    editMessageTextView.bottomAnchor.constraint(equalTo: completeButton.topAnchor, constant: -AlertBaseUIView.convertHeight(value: 15)).isActive = true
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension AlertReportContentView: UITextViewDelegate {
  public func textViewDidBeginEditing(_ textView: UITextView) {
    textView.font = UIFont.systemFont(ofSize: 12)
    textView.textColor = .white
    textView.text = ""
  }
}
