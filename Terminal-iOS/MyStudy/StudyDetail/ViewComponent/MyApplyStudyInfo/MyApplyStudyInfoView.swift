//
//  MyApplyStudyDetailView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2021/01/29.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit
import TerminalAlert

final class MyApplyStudyInfoView: UIViewController {
    var applyStudy: ApplyStudy?
    var presenter: MyApplyStudyInfoPresenterProtocol?
    
    let mainImageView = MainImageView(frame: CGRect.zero)
    let studyTitleLabel = TitleWithContentView()
    let applyMessageLabel = TitleWithContentView()
    let moreButton = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        if let parent = self.navigationController?.viewControllers.last {
            parent.viewDidLoad()
        }
    }
    
    func attribute() {
        self.do {
            $0.navigationItem.rightBarButtonItems = [moreButton]
            $0.view.backgroundColor = .appColor(.terminalBackground)
        }
        mainImageView.do {
            guard let image = applyStudy?.image else { return }
            $0.contentMode = .scaleAspectFill
            $0.layer.masksToBounds = true
            $0.backgroundColor = .systemGray5
            if image.isEmpty {
                $0.backgroundColor = .systemGray5
                $0.defaultStudyImage()
            } else {
                $0.kf.setImage(with: URL(string: image),
                               options: [.requestModifier(RequestToken.token())])
                $0.tintColor = .none
                $0.contentMode = .scaleAspectFill
            }
        }
        self.studyTitleLabel.do {
            $0.backgroundColor = UIColor.appColor(.InputViewColor)
            guard let title = applyStudy?.title else { return }
            $0.contentText = ["스터디 제목", title]
        }
        self.applyMessageLabel.do {
            guard let message = applyStudy?.message else { return }
            $0.contentText = ["신청 메세지", message]
        }
        self.moreButton.do {
            $0.image = UIImage(systemName: "ellipsis")?.withConfiguration(UIImage.SymbolConfiguration(weight: .regular))
            $0.target = self
            $0.action = #selector(moreButtonDidTap)
        }
    }
    
    func layout() {
        [ mainImageView, studyTitleLabel, applyMessageLabel ].forEach { view.addSubview($0) }
        
        mainImageView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeight(value: 170)).isActive = true
        }
        studyTitleLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: Terminal.convertHeight(value: 23)).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Terminal.convertWidth(value: 24)).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Terminal.convertWidth(value: 24)).isActive = true
            $0.bottomAnchor.constraint(equalTo: $0.label.bottomAnchor ).isActive = true
        }
        applyMessageLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: studyTitleLabel.bottomAnchor, constant: Terminal.convertHeight(value: 23)).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Terminal.convertWidth(value: 24)).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Terminal.convertWidth(value: 24)).isActive = true
            $0.bottomAnchor.constraint(equalTo: $0.label.bottomAnchor ).isActive = true
        }
    }
    
    @objc func moreButtonDidTap() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let modify = UIAlertAction(title: "수정하기", style: .default, handler: {_ in self.modifyButtonDidTap() })
        let delete = UIAlertAction(title: "신청취소", style: .destructive, handler: {_ in self.deleteButtonDidTap() })
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        [modify, delete, cancel].forEach { actionSheet.addAction($0) }
        if UIDevice.current.userInterfaceIdiom == .pad {
            if let popoverController = actionSheet.popoverPresentationController {
                popoverController.sourceView = self.view
                popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
                popoverController.permittedArrowDirections = []
                self.present(actionSheet, animated: true, completion: nil)
                
            }
        } else {
            present(actionSheet, animated: true, completion: nil)
        }
    }
    
    func modifyButtonDidTap() {
        guard let id = applyStudy?.studyID else { return }
        presenter?.modifyButtonDidTap(studyID: id)
    }
    
    func deleteButtonDidTap() {
        TerminalAlertMessage.show(controller: self, type: .StudyApplyDeleteView)
        if let alertVC = (TerminalAlertMessage.alert.value(forKey: "contentViewController") as? UIViewController) {
            if let alertBaseVIew = alertVC.view as? AlertBaseUIView {
                alertBaseVIew.completeButton.addTarget(self, action: #selector(applyCancelButtonDidTap), for: .touchUpInside)
            }
        }
    }
    
    @objc func applyCancelButtonDidTap() {
        presenter?.deleteButtonDidTap()
    }
}

extension MyApplyStudyInfoView: MyApplyStudyInfoViewProtocol {
    func showDeleteApply(message: String) {
        TerminalAlertMessage.dismiss()
        showToast(controller: self, message: message, seconds: 1) {
            self.navigationController?.popViewController(animated: true)
            if let lastIndex = self.navigationController?.viewControllers.endIndex {
                if let parent = self.navigationController?.viewControllers[lastIndex - 2] {
                    parent.viewDidLoad()
                }
            }
        }
    }
    
    func showError(message: String) {
        TerminalAlertMessage.dismiss()
        showToast(controller: self, message: message, seconds: 1)
    }
}
