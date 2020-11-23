//
//  StudyIntroduceLabel.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/10/30.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class TitleWithContentView: UIView {
    var title = UILabel()
    var label = UILabel()
    var textView = UITextView()
    var state: StudyDetailViewState = .none
    var contentText: [String] = ["기본 제목", "기본 텍스트"] {
        didSet {
            attribute()
        }
    }
    
    init(state: StudyDetailViewState) {
        super.init(frame: CGRect.zero)
        attribute()
        self.state = state
        if state == .none || state == .member{
            labelLayout()
        } else if state == .edit{
            textViewLayout()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func attribute() {
        self.do {
            $0.backgroundColor = UIColor.appColor(.terminalBackground)
        }
        title.do {
            $0.font = UIFont.boldSystemFont(ofSize: 18)
            $0.text = contentText[0]
        }
        label.do {
            $0.font.withSize(16)
            $0.numberOfLines = 0
            $0.text = contentText[1]
            $0.setLineSpacing(lineSpacing: 13, lineHeightMultiple: 0)
        }
        textView.do {
            $0.font = UIFont.boldSystemFont(ofSize: 16)
            $0.layer.cornerRadius = 10
            $0.layer.masksToBounds = false
            $0.backgroundColor = UIColor.appColor(.InputViewColor)
            $0.text = contentText[1]
        }
    }
    
    func labelLayout() {
        [title, label, textView].forEach { addSubview($0) }
        label.isHidden = false
        textView.isHidden = true
        title.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            $0.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: title.intrinsicContentSize.height).isActive = true
        }
        label.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: title.bottomAnchor, constant: Terminal.convertHeigt(value: 10)).isActive = true
            $0.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            $0.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
            $0.heightAnchor.constraint(equalTo: label.heightAnchor).isActive = true
        }
    }
    func textViewLayout() {
        [title, label, textView].forEach { addSubview($0) }
        
        label.isHidden = true
        textView.isHidden = false
        
        title.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            $0.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: title.intrinsicContentSize.height).isActive = true
        }
        textView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: title.bottomAnchor, constant: Terminal.convertHeigt(value: 10)).isActive = true
            $0.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            $0.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: textView.intrinsicContentSize.height + 100).isActive = true
        }
    }
    func titleHidden() {
        title.isHidden = true
        if self.state == .edit{
            textView.do {
                $0.translatesAutoresizingMaskIntoConstraints = false
                $0.topAnchor.constraint(equalTo: title.bottomAnchor, constant: Terminal.convertHeigt(value: 10)).isActive = true
                $0.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
                $0.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
                $0.heightAnchor.constraint(equalTo: textView.heightAnchor).isActive = true
            }
        } else {
            label.do {
                $0.topAnchor.constraint(equalTo: topAnchor).isActive = true
                $0.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
                $0.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
                $0.heightAnchor.constraint(equalTo: label.heightAnchor).isActive = true
            }
        }
    }
}
