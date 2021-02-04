//
//  TempStudyDetailViewController.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/10/29.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import NMapsMap
import SwiftKeychainWrapper
import Kingfisher
import Lottie

enum StudyDetailViewState: String {
    case edit
    case member
    case host
    case none
    case applier
    case reject
}

class StudyDetailView: UIViewController {
    var presenter: StudyDetailPresenterProtocol?
    var state: StudyDetailViewState = .member {
        didSet {
            attribute()
        }
    }
    var userData: [Participate] = []
    var studyID: Int? {
        didSet {
            presenter?.showStudyListDetail(studyID: "\(studyID!)")
        }
    }
    var studyInfo: StudyDetail? {
        didSet {
            attribute()
        }
    }
    weak var parentView: MyStudyDetailViewProtocol?
    var scrollView = UIScrollView()
    var tempBackgroundView = UIView()
    let picker = UIImagePickerController()
    var mainImageViewTapGesture = UITapGestureRecognizer()
    var mainImageView = MainImageView(frame: CGRect.zero)
    var snsIconsView = StudyDetailSNSView()
    lazy var studyIntroduceView = TitleWithContentView()
    var memberView = MemeberView()
    lazy var studyPlanView = TitleWithContentView()
    lazy var timeView = TitleWithContentView()
    lazy var locationView = TitleWithContentView()
    var mapView = NMFMapView()
    var joinButton = UIButton()
    let joinProgressCatTapGesture = UITapGestureRecognizer(target: self, action: #selector(modifyJoinButtonDidTap))
    var joinProgressCat = AnimationView(name: "14476-rainbow-cat-remix")
    var studyTitle: String? {
        didSet {
            self.title = studyTitle
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
    
    func attribute() {
        self.do {
            if let title = studyInfo?.title {
                $0.title = title
            } else {
                $0.title = studyTitle
            }
        }
        view.do {
            $0.backgroundColor = UIColor.appColor(.terminalBackground)
        }
        
        tempBackgroundView.do {
            $0.backgroundColor = UIColor.appColor(.terminalBackground)
        }
        
        mainImageView.do {
            $0.isUserInteractionEnabled = false
            let imageURL = studyInfo?.image ?? ""
            $0.kf.setImage(with: URL(string: imageURL),
                           placeholder: UIImage(named: "swift"),
                           options: [.requestModifier(RequestToken.token())])
        }
        
        snsIconsView.do {
            if let notion = studyInfo?.snsNotion {
                $0.notion.isHidden = notion.isEmpty ? true : false
            }
            if let evernote = studyInfo?.snsEvernote {
                $0.evernote.isHidden = evernote.isEmpty ? true : false
            }
            if let web = studyInfo?.snsWeb {
                $0.web.isHidden = web.isEmpty ? true : false
            }
        }
        
        joinButton.do {
            $0.tag = 0
            if state == .none || state == .reject {
                $0.isHidden = false
                $0.setTitle("스터디 참여하기", for: .normal)
                $0.titleLabel?.font = UIFont.systemFont(ofSize: 16)
                $0.setTitleColor(.white, for: .normal)
                $0.backgroundColor = UIColor.appColor(.mainColor)
                $0.layer.cornerRadius = 10
                $0.clipsToBounds = false
                $0.removeTarget(self, action: #selector(modifyJoinButtonDidTap), for: .touchUpInside)
                $0.addTarget(self, action: #selector(joinButtonDidTap), for: .touchUpInside)
            } else if state == .applier {
                $0.isHidden = false
                $0.setTitle("가입 진행중", for: .normal)
                $0.titleLabel?.font = UIFont.systemFont(ofSize: 16)
                $0.backgroundColor = UIColor.appColor(.terminalBackground)
                $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 10)
                $0.setTitleColor(UIColor.appColor(.mainColor), for: .normal)
                $0.layer.cornerRadius = 10
                $0.clipsToBounds = false
                $0.contentHorizontalAlignment = .right
                $0.layer.borderWidth = 0.1
                $0.layer.borderColor = UIColor.gray.cgColor
                $0.removeTarget(self, action: #selector(joinButtonDidTap), for: .touchUpInside)
                $0.addTarget(self, action: #selector(modifyJoinButtonDidTap), for: .touchUpInside)
            } else {
                $0.isHidden = true
            }
        }
        
        studyIntroduceView.do {
            $0.contentText = ["스터디 소개", String(studyInfo?.introduce ?? "")]
            if state == .none || state == .member {
            } else {
            }
        }
        
        memberView.do {
            $0.collectionView.delegate = self
            $0.collectionView.dataSource = self
        }
        
        studyPlanView.do {
            $0.title.text = "스터디 진행"
            $0.contentText = ["스터디 진행", String(studyInfo?.progress ?? "")]
            if state == .none || state == .member {
            } else {
            }
        }
        
        timeView.do {
            $0.title.text = "시간"
            $0.contentText = ["시간", String(studyInfo?.studyTime ?? "")]
            if state == .none || state == .member {
            } else {
            }
        }
        
        locationView.do {
            var detailAddress = ""
            if let item = studyInfo?.location.locationDetail {
                detailAddress = item
            }
            $0.title.text = "장소"
            $0.contentText = ["장소", String(studyInfo?.location.addressName ?? "") +  detailAddress]
        }
        
        joinProgressCat.do {
            $0.addGestureRecognizer(joinProgressCatTapGesture)
            $0.isUserInteractionEnabled = false
            if state == .none || state == .reject {
                $0.isHidden = true
                $0.stop()
            } else if state == .applier {
                $0.isHidden = false
                $0.play()
                $0.loopMode = .loop
            } else {
                print(state)
                $0.isHidden = true
            }
        }
    }
    
    func layout() {
        view.addSubview(scrollView)
        scrollView.addSubview(tempBackgroundView)
        
        [mainImageView, joinButton, snsIconsView, studyIntroduceView, memberView, studyPlanView, timeView, locationView, mapView, joinProgressCat].forEach { tempBackgroundView.addSubview($0) }
        
        scrollView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            $0.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            $0.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
        tempBackgroundView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
            $0.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
            $0.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        }
        mainImageView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerXAnchor.constraint(equalTo: tempBackgroundView.centerXAnchor).isActive = true
            $0.topAnchor.constraint(equalTo: tempBackgroundView.topAnchor).isActive = true
            $0.widthAnchor.constraint(equalTo: tempBackgroundView.widthAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeigt(value: 169)).isActive = true
        }
        snsIconsView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 5).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
            $0.trailingAnchor.constraint(equalTo: joinButton.leadingAnchor).isActive = true
            $0.heightAnchor.constraint(equalTo: snsIconsView.heightAnchor).isActive = true
        }
        joinButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: snsIconsView.centerYAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: tempBackgroundView.trailingAnchor, constant: -Terminal.convertWidth(value: 24)).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 150)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeigt(value: 36)).isActive = true
        }
        studyIntroduceView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: snsIconsView.bottomAnchor, constant: Terminal.convertHeigt(value: 23)).isActive = true
            $0.leadingAnchor.constraint(equalTo: tempBackgroundView.leadingAnchor, constant: Terminal.convertWidth(value: 24)).isActive = true
            $0.trailingAnchor.constraint(equalTo: tempBackgroundView.trailingAnchor, constant: -Terminal.convertWidth(value: 24)).isActive = true
            $0.bottomAnchor.constraint(equalTo: studyIntroduceView.label.isHidden == false ? studyIntroduceView.label.bottomAnchor : studyIntroduceView.label.bottomAnchor ).isActive = true
        }
        memberView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: studyIntroduceView.bottomAnchor, constant: Terminal.convertHeigt(value: 23)).isActive = true
            $0.leadingAnchor.constraint(equalTo: tempBackgroundView.leadingAnchor, constant: Terminal.convertWidth(value: 24)).isActive = true
            $0.trailingAnchor.constraint(equalTo: tempBackgroundView.trailingAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: $0.collectionView.bottomAnchor).isActive = true
        }
        studyPlanView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: memberView.bottomAnchor, constant: Terminal.convertHeigt(value: 23)).isActive = true
            $0.leadingAnchor.constraint(equalTo: tempBackgroundView.leadingAnchor, constant: Terminal.convertWidth(value: 24)).isActive = true
            $0.trailingAnchor.constraint(equalTo: tempBackgroundView.trailingAnchor, constant: -Terminal.convertWidth(value: 24)).isActive = true
            $0.bottomAnchor.constraint(equalTo: studyPlanView.label.isHidden == false ? studyPlanView.label.bottomAnchor : studyPlanView.label.bottomAnchor ).isActive = true
        }
        timeView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: studyPlanView.bottomAnchor, constant: Terminal.convertHeigt(value: 23)).isActive = true
            $0.leadingAnchor.constraint(equalTo: tempBackgroundView.leadingAnchor, constant: Terminal.convertWidth(value: 24)).isActive = true
            $0.trailingAnchor.constraint(equalTo: tempBackgroundView.trailingAnchor, constant: -Terminal.convertWidth(value: 24)).isActive = true
            $0.bottomAnchor.constraint(equalTo: timeView.label.isHidden == false ? timeView.label.bottomAnchor : timeView.label.bottomAnchor ).isActive = true
        }
        locationView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: timeView.bottomAnchor, constant: Terminal.convertHeigt(value: 23)).isActive = true
            $0.leadingAnchor.constraint(equalTo: tempBackgroundView.leadingAnchor, constant: Terminal.convertWidth(value: 24)).isActive = true
            $0.trailingAnchor.constraint(equalTo: tempBackgroundView.trailingAnchor, constant: -Terminal.convertWidth(value: 24)).isActive = true
            $0.bottomAnchor.constraint(equalTo: locationView.label.isHidden == false ? locationView.label.bottomAnchor : locationView.label.bottomAnchor).isActive = true
        }
        mapView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: locationView.bottomAnchor, constant: Terminal.convertHeigt(value: 23)).isActive = true
            $0.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 254)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeigt(value: 186)).isActive = true
            $0.bottomAnchor.constraint(equalTo: tempBackgroundView.bottomAnchor).isActive = true
        }
        joinProgressCat.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: joinButton.centerYAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: joinButton.leadingAnchor, constant: 5).isActive = true
            $0.widthAnchor.constraint(equalTo: joinButton.widthAnchor, multiplier: 0.45).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeigt(value: 72)).isActive = true
        }
    }
  
    @objc func joinButtonDidTap() {
        TerminalAlertMessage.show(controller: self, type: .StudyApplyView)
        TerminalAlertMessage.getAlertCompleteButton().addTarget(self, action: #selector(studyApplyMessageEndEditing), for: .touchUpInside)
    }
    
    @objc func modifyJoinButtonDidTap() {
        guard let id = studyID else { return }
        presenter?.modifyStudyMessageButtonDidTap(studyID: id)
    }
    
    @objc func studyApplyMessageEndEditing() {
        if let contentViewController = TerminalAlertMessage.alert.value(forKey: "contentViewController"),
           let castContentViewController = contentViewController as? UIViewController {
            if let alertView = castContentViewController.view {
                if let messageView = alertView as? StudyApplyMessageView {
                    guard let message =  messageView.editMessageTextField.text else { return }
                    presenter?.joinButtonDidTap(studyID: studyID!, message: message)
                }
            }
        }
        
        TerminalAlertMessage.dismiss()
    }
}

extension StudyDetailView: StudyDetailViewProtocol {
    func studyJoinResult(message: String) {
        showToast(controller: self, message: message, seconds: 1)
        presenter?.showStudyListDetail(studyID: "\(studyInfo!.id)")
    }
    
    func showStudyDetail(with studyDetail: StudyDetail) {
        var snsList: [String: String] = [:]
        self.studyInfo = studyDetail
        userData = studyDetail.participate
        state = StudyDetailViewState.init(rawValue: studyDetail.authority)!
        memberView.collectionView.reloadData()
        memberView.totalMember.text = "\(userData.count) 명"
        parentView?.setting()

        if let notion = studyDetail.snsNotion,
           let evernote = studyDetail.snsEvernote,
           let web = studyDetail.snsWeb {
            if !notion.isEmpty {
                snsList.updateValue(notion, forKey: "notion")
            }
            if !evernote.isEmpty {
                snsList.updateValue(evernote, forKey: "evernote")
            }
            if !web.isEmpty {
                snsList.updateValue(web, forKey: "web")
            }
        }
        self.snsIconsView.addstack(snsList: snsList)
        attribute()
    }
    
    func showError(message: String) {
        showToast(controller: self, message: message, seconds: 1)
    }
    
    func showLoading() {
        
    }
    
    func hideLoading() {
        
    }
}

extension StudyDetailView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = memberView.collectionView.dequeueReusableCell(withReuseIdentifier: MemberCollectionViewCell.identifier, for: indexPath) as! MemberCollectionViewCell
        cell.setData(userInfo: userData[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
}
