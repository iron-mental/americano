//
//  EmailAlertMessageView.swift
//  TerminalAlert
//
//  Created by once on 2021/05/31.
//

import UIKit

class EmailAlertMessageView: AlertBaseUIView {
  var alertMessageLabel = UILabel()
  var message: String?
  
  init(message: String) {
    super.init()
    self.message = message
    attribute()
    layout()
  }
  
  override func attribute() {
    super.attribute()
    alertMessageLabel.textColor = .white
    alertMessageLabel.numberOfLines = 0
    alertMessageLabel.textAlignment = .center
    alertMessageLabel.font = UIFont.systemFont(ofSize: 13)
    alertMessageLabel.text = self.message ?? ""
  }
  
  override func layout() {
    super.layout()
    self.addSubview(alertMessageLabel)
    alertMessageLabel.translatesAutoresizingMaskIntoConstraints = false
    alertMessageLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    alertMessageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -20).isActive = true
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
