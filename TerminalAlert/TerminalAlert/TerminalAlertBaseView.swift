//
//  TerminalAlertBaseView.swift
//  TerminalAlert
//
//  Created by once on 2021/05/31.
//

import UIKit

public class AlertBaseUIView: UIView {
  
  static func convertHeight(value: CGFloat) -> CGFloat {
      return UIScreen.main.bounds.height * (value / 667)
  }
  
  static func convertWidth(value: CGFloat) -> CGFloat {
      return UIScreen.main.bounds.width * (value / 375)
  }
  
  public var redButton = UIButton()
  public var yellowButton = UIButton()
  public var greenButton = UIButton()
  public var topBar = UIView()
  public var bottomBar = UIView()
  public var dismissButton = UIButton()
  public var completeButton = UIButton()
  
  init() {
    super.init(frame: CGRect.zero)
    layout()
    attribute()
  }
  
  func attribute() {
    
    self.backgroundColor = #colorLiteral(red: 0.1176470588, green: 0.1176470588, blue: 0.1215686275, alpha: 1)
    self.layer.cornerRadius = 5
    self.layer.masksToBounds = true
    self.alpha = 1
    
    
    topBar.backgroundColor = #colorLiteral(red: 0.2392156863, green: 0.2352941176, blue: 0.2352941176, alpha: 1)
    topBar.layer.cornerRadius = 5
    topBar.layer.masksToBounds = true
    
    bottomBar.backgroundColor = #colorLiteral(red: 0.1176470588, green: 0.1176470588, blue: 0.1215686275, alpha: 1)
    
    redButton.layer.masksToBounds = true
    redButton.layer.cornerRadius = 5
    redButton.backgroundColor = #colorLiteral(red: 0.9254901961, green: 0.3960784314, blue: 0.3529411765, alpha: 1)
    redButton.setTitle("", for: .normal)
    
    yellowButton.layer.masksToBounds = true
    yellowButton.layer.cornerRadius = 5
    yellowButton.backgroundColor = #colorLiteral(red: 0.8784313725, green: 0.7529411765, blue: 0.2980392157, alpha: 1)
    yellowButton.setTitle("", for: .normal)
    
    greenButton.layer.masksToBounds = true
    greenButton.layer.cornerRadius = 5
    greenButton.backgroundColor = #colorLiteral(red: 0.4470588235, green: 0.7450980392, blue: 0.2784313725, alpha: 1)
    greenButton.setTitle("", for: .normal)
    
    dismissButton.setTitle("취소", for: .normal)
    dismissButton.setTitleColor(.systemGray, for: .normal)
    dismissButton.backgroundColor = #colorLiteral(red: 0.1176470588, green: 0.1176470588, blue: 0.1215686275, alpha: 1)
    dismissButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
     
    completeButton.setTitle("확인", for: .normal)
    completeButton.setTitleColor(#colorLiteral(red: 0.1607843137, green: 0.462745098, blue: 0.9529411765, alpha: 1), for: .normal)
    completeButton.backgroundColor = #colorLiteral(red: 0.1176470588, green: 0.1176470588, blue: 0.1215686275, alpha: 1)
    completeButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
    
  }
  
  func layout() {
    [ topBar, bottomBar ].forEach { addSubview($0) }
    [ redButton, yellowButton, greenButton ].forEach { topBar.addSubview($0) }
    [ dismissButton, completeButton ].forEach { bottomBar.addSubview($0) }
    
    
    topBar.translatesAutoresizingMaskIntoConstraints = false
    topBar.topAnchor.constraint(equalTo: topAnchor).isActive = true
    topBar.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    topBar.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    topBar.heightAnchor.constraint(equalToConstant: 20).isActive = true
    
    
    bottomBar.translatesAutoresizingMaskIntoConstraints = false
    bottomBar.topAnchor.constraint(equalTo: topBar.bottomAnchor, constant: -3).isActive = true
    bottomBar.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
    bottomBar.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    bottomBar.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    
    
    redButton.translatesAutoresizingMaskIntoConstraints = false
    redButton.centerYAnchor.constraint(equalTo: topBar.centerYAnchor, constant: -2).isActive = true
    redButton.heightAnchor.constraint(equalToConstant: 10).isActive = true
    redButton.leadingAnchor.constraint(equalTo: topBar.leadingAnchor, constant: 13).isActive = true
    redButton.widthAnchor.constraint(equalToConstant: 10).isActive = true
    
    
    yellowButton.translatesAutoresizingMaskIntoConstraints = false
    yellowButton.centerYAnchor.constraint(equalTo: redButton.centerYAnchor).isActive = true
    yellowButton.heightAnchor.constraint(equalToConstant: 10).isActive = true
    yellowButton.leadingAnchor.constraint(equalTo: redButton.trailingAnchor, constant: 13).isActive = true
    yellowButton.widthAnchor.constraint(equalToConstant: 10).isActive = true
    
    
    greenButton.translatesAutoresizingMaskIntoConstraints = false
    greenButton.centerYAnchor.constraint(equalTo: redButton.centerYAnchor).isActive = true
    greenButton.heightAnchor.constraint(equalToConstant: 10).isActive = true
    greenButton.leadingAnchor.constraint(equalTo: yellowButton.trailingAnchor, constant: 13).isActive = true
    greenButton.widthAnchor.constraint(equalToConstant: 10).isActive = true
    
    
    dismissButton.translatesAutoresizingMaskIntoConstraints = false
    dismissButton.heightAnchor.constraint(equalToConstant: AlertBaseUIView.convertHeight(value: 30)).isActive = true
    dismissButton.bottomAnchor.constraint(equalTo: bottomBar.bottomAnchor, constant: -10).isActive = true
    dismissButton.leadingAnchor.constraint(equalTo: bottomBar.leadingAnchor).isActive = true
    dismissButton.trailingAnchor.constraint(equalTo: bottomBar.centerXAnchor).isActive = true
    
    
    completeButton.translatesAutoresizingMaskIntoConstraints = false
    completeButton.heightAnchor.constraint(equalToConstant: AlertBaseUIView.convertHeight(value: 30)).isActive = true
    completeButton.bottomAnchor.constraint(equalTo: bottomBar.bottomAnchor, constant: -10).isActive = true
    completeButton.leadingAnchor.constraint(equalTo: bottomBar.centerXAnchor).isActive = true
    completeButton.trailingAnchor.constraint(equalTo: bottomBar.trailingAnchor).isActive = true
    
  }
  
  
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

