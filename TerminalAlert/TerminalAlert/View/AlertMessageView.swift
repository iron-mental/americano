//
//  AlertMessageView.swift
//  TerminalAlert
//
//  Created by once on 2021/05/31.
//

import UIKit

public class AlertMessageView: AlertBaseUIView {
  public var alertMessageLabel = UILabel()
  public var alertMessage = ""
  
  init(message: String) {
    super.init()
    alertMessage = message
    attribute()
    layout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func attribute() {
    super.attribute()
    
    alertMessageLabel.numberOfLines = 3
    alertMessageLabel.textAlignment = .center
    alertMessageLabel.textColor = .white
    alertMessageLabel.font = UIFont.systemFont(ofSize: 13)
    alertMessageLabel.text = alertMessage
  }
  
  override func layout() {
    super.layout()
    self.addSubview(alertMessageLabel)
    
    alertMessageLabel.translatesAutoresizingMaskIntoConstraints = false
    alertMessageLabel.centerXAnchor.constraint(equalTo: bottomBar.centerXAnchor).isActive = true
    alertMessageLabel.centerYAnchor.constraint(equalTo: bottomBar.centerYAnchor, constant: -20).isActive = true
  }
  
  func onlyCompleteButton() {
    dismissButton.isHidden = true
    completeButton.leadingAnchor.constraint(equalTo: bottomBar.leadingAnchor).isActive = true
  }
  
  func dynamicLabelFontSize() {}
}
