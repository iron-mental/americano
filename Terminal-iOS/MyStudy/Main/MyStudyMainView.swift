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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
    
    func attribute() {
        view.do {
            $0.backgroundColor = UIColor.appColor(.terminalBackground)
        }
        self.do {
            $0.title = "내 스터디"
        }
        moreButton = UIBarButtonItem(title: "왜이래", style: .plain, target: self, action: #selector(moreButtonAction(_ :)))
        moreButton?.do {
            //추후에 more버튼으로 교체
            $0.image = #imageLiteral(resourceName: "Vaild")
        }
        
    }
    
    func layout() {
        self.navigationItem.rightBarButtonItem = moreButton
    }
    
    @objc func moreButtonAction(_ sender: UIBarButtonItem) {
        print("clicked more Button!!")
    }
}

extension MyStudyMainView: MyStudyMainViewProtocol {
    
}
