//
//  SearchLocationView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/10/29.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class SearchLocationView: UIViewController {
    var presenter: SearchLocationPresenterProtocol?
    
    var closeButton = UIButton()
    var searchButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
    
    func attribute() {
        self.do {
            $0.view.backgroundColor = .systemBackground
        }
        closeButton.do {
            $0.setImage(#imageLiteral(resourceName: "back"), for: .normal)
            $0.addTarget(self, action: #selector(didCloseButtonClicked), for: .touchUpInside)
        }
        searchButton.do {
            $0.setImage(#imageLiteral(resourceName: "search"), for: .normal)
            $0.addTarget(self, action: #selector(didSearchButtonClicked), for: .touchUpInside)
        }
    }
    
    func layout() {
        [closeButton, searchButton].forEach { view.addSubview($0) }
        
        closeButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Terminal.convertWidth(value: 15)).isActive = true
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Terminal.convertHeigt(value: 18)).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 30)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 30)).isActive = true
        }
        searchButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Terminal.convertWidth(value: 29)).isActive = true
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Terminal.convertHeigt(value: 18)).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 30)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 30)).isActive = true
        }
    }
    
    @objc func didCloseButtonClicked() {
        dismiss(animated: true)
    }
    @objc func didSearchButtonClicked() {
        //do something
    }
}

extension SearchLocationView: SearchLocationViewProtocol {
    
}
