//
//  MyApplyStudyDetailView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/29.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

class MyApplyStudyInfoView: UIViewController {
    var applyStudy: ApplyStudy?
    
    let mainImageView = UIImageView()
    let studyTitleLabel = PaddingLabel()
    let applyMessageLabel = PaddingLabel()
    let moreButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        
        [ mainImageView, studyTitleLabel, applyMessageLabel, moreButton ].forEach { view.addSubview($0) }
    }
    
    func attribute() {
        mainImageView.do {
            guard let image = applyStudy?.image else { return }
            $0.kf.setImage(with: URL(string: image), options: [.requestModifier(RequestToken.token())])
        }
        studyTitleLabel.do {
            guard let title = applyStudy?.title else { return }
            $0.text = title
        }
        applyMessageLabel.do {
            guard let message = applyStudy?.message else { return }
            $0.text = message
        }
        moreButton.do {
            $0.setImage(#imageLiteral(resourceName: "more"), for: .normal)
            $0.addTarget(self, action: #selector(moreButtonDidTap), for: .touchUpInside)
        }
    }
    
    @objc func moreButtonDidTap() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let modify = UIAlertAction(title: "수정하기", style: .default, handler: {_ in self.modifyButtonDidTap() })
        let delete = UIAlertAction(title: "신청취소", style: .default, handler: {_ in self.deleteButtonDidTap() })
        
        [modify, delete].forEach { actionSheet.addAction($0) }
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func modifyButtonDidTap() {
        
    }
    
    func deleteButtonDidTap() {
        
    }
}

extension MyApplyStudyInfoView: MyApplyStudyInfoViewProtocol {
    
}
