//
//  StudyOverViewUIView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/20.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

final class TitleWithTextView: UIView {
    var seletedCategory: String?
    var titleLabel = UILabel()
    var title: String?
    var categoryLabel = UILabel()
    var textView = UITextView()
    var staroflifeImageView = UIImageView()
    
    init(title: String) {
        super.init(frame: .zero)
        self.title = title
        attribute()
        layout()
    }
    
    func attribute() {
        self.titleLabel.do {
            $0.text = self.title
            $0.backgroundColor = UIColor.appColor(.testColor)
            $0.dynamicFont(fontSize: $0.font.pointSize, weight: .medium)
        }
        self.categoryLabel.do {
            $0.textColor = .white
            $0.backgroundColor = UIColor.appColor(.terminalBackground)
            $0.dynamicFont(fontSize: $0.font.pointSize, weight: .medium)
        }
        self.textView.do {
            $0.backgroundColor = UIColor.appColor(.InputViewColor)
            $0.layer.cornerRadius = 10
            $0.dynamicFont(size: 15, weight: .regular)
            $0.layer.borderWidth = 0.1
            $0.layer.borderColor = UIColor.gray.cgColor
        }
        self.staroflifeImageView.do {
            $0.image = UIImage(systemName: "staroflife.fill")?.withConfiguration(UIImage.SymbolConfiguration(weight: .light))
            $0.tintColor = UIColor.appColor(.mainColor)
            $0.contentMode = .scaleAspectFit
        }
    }
    
    func layout() {
        [titleLabel, categoryLabel, textView, staroflifeImageView].forEach {
            self.addSubview($0)
        }
        
        titleLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        }
        staroflifeImageView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.titleLabel.topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor,
                                        constant: Terminal.convertWidth(value: 5)).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 15)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 15)).isActive = true
        }
        categoryLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.titleLabel.topAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        }
        textView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor,
                                    constant: Terminal.convertHeight(value: 17)).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            $0.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
