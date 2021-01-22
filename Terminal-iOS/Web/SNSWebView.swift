//
//  SNSWebView.swift
//  Terminal-iOS
//
//  Created by once on 2021/01/18.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit
import WebKit

class SNSWebView: UIViewController {
    
    let webView = WKWebView()
    var url: String?
    
    init(url: String) {
        super.init(nibName: nil, bundle: nil)
        self.url = url
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        if let url = self.url {
            let url = URL(string: url)!
            let urlRequest = URLRequest(url: url)
            webView.load(urlRequest)
        }
    }
    
    private func layout() {
        self.view.addSubview(self.webView)
        self.webView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        }
    }
}
