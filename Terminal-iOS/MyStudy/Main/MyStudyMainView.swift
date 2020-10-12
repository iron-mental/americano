//
//  MyStudyMainView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/10/11.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class MyStudyMainView: UIViewController {
    var presenter: MyStudyMainPresenterProtocol?
    
    var moreButton: UIBarButtonItem?
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
    
    func attribute() {
        view.do {
            $0.backgroundColor = UIColor.appColor(.terminalBackground)
        }
        moreButton = UIBarButtonItem(title: "왜이래", style: .plain, target: self, action: #selector(moreButtonAction(_ :)))
        moreButton?.do {
            //추후에 more버튼으로 교체
            $0.image = #imageLiteral(resourceName: "Vaild")
        }
        self.do {
            $0.title = "내 스터디"
            $0.navigationItem.rightBarButtonItem = moreButton
        }
        tableView.do {
            $0.backgroundColor = .cyan
            
        }
    }
    
    func layout() {
        view.addSubview(tableView)
        
        tableView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        }
    }
    
    @objc func moreButtonAction(_ sender: UIBarButtonItem) {
        print("clicked more Button!!")
    }
}

extension MyStudyMainView: MyStudyMainViewProtocol {
    
}

extension MyStudyMainView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
