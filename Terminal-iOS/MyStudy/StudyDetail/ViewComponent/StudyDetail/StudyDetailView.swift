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

enum StudyDetailViewState: String {
    case edit
    case member
    case host
    case none
    case applier
    case rejected
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
    var parentView: MyStudyDetailViewProtocol?
    var scrollView = UIScrollView()
    var tempBackgroundView = UIView()
    let picker = UIImagePickerController()
    var mainImageViewTapGesture = UITapGestureRecognizer()
    var mainImageView = MainImageView(frame: CGRect.zero)
    var snsIconsView = SNSIconsView(frame: CGRect.zero)
    lazy var studyIntroduceView = TitleWithContentView()
    var memberView = MemeberView()
    lazy var studyPlanView = TitleWithContentView()
    lazy var timeView = TitleWithContentView()
    lazy var locationView = TitleWithContentView()
    var mapView = NMFMapView()
    var joinButton = UIButton()
    var panddingButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
    }
    
    func attribute() {
        let token = KeychainWrapper.standard.string(forKey: "accessToken")!
        let imageDownloadRequest = AnyModifier { request in
            var requestBody = request
            requestBody.setValue("Bearer "+token, forHTTPHeaderField: "Authorization")
            return requestBody
        }
        view.do {
            $0.backgroundColor = UIColor.appColor(.terminalBackground)
        }
        tempBackgroundView.do {
            $0.backgroundColor = UIColor.appColor(.terminalBackground)
        }
        mainImageView.do {
            $0.isUserInteractionEnabled = false
            if let imageURL =  studyInfo?.image {
                $0.kf.setImage(with: URL(string: imageURL), options: [.requestModifier(imageDownloadRequest)])
            } else {
                $0.image = #imageLiteral(resourceName: "ios")
            }
        }
        joinButton.do {
            if state == .none || state == .rejected {
                $0.isHidden = false
                $0.setTitle("스터디 참여하기", for: .normal)
                $0.titleLabel?.font = UIFont.systemFont(ofSize: 13)
                $0.setTitleColor(.white, for: .normal)
                $0.backgroundColor = UIColor.appColor(.mainColor)
                $0.layer.cornerRadius = 10
                $0.clipsToBounds = false
                $0.addTarget(self, action: #selector(joinButtonDidTap), for: .touchUpInside)
            } else {
                $0.isHidden = true
            }
        }
        studyIntroduceView.do {
            $0.contentText = ["스터디 소개",String(studyInfo?.introduce ?? "")]
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
            print(detailAddress)
            
            $0.title.text = "장소"
            $0.contentText = ["장소",  String(studyInfo?.location.addressName ?? "") +  detailAddress]
        }
    }
    
    func layout() {
        view.addSubview(scrollView)
        scrollView.addSubview(tempBackgroundView)
        
        [mainImageView, joinButton, snsIconsView, studyIntroduceView, memberView, studyPlanView, timeView, locationView, mapView].forEach { tempBackgroundView.addSubview($0) }
        
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
            $0.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: Terminal.convertHeigt(value: 23)).isActive = true
            $0.leadingAnchor.constraint(equalTo: tempBackgroundView.leadingAnchor, constant: Terminal.convertWidth(value: 24)).isActive = true
            $0.widthAnchor.constraint(equalToConstant: snsIconsView.intrinsicContentSize.width).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 22)).isActive = true
        }
        joinButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: snsIconsView.centerYAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: tempBackgroundView.trailingAnchor, constant: -Terminal.convertWidth(value: 24)).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 113)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeigt(value: 18)).isActive = true
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
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeigt(value: 96)).isActive = true
        }
        studyPlanView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: memberView.bottomAnchor,constant: Terminal.convertHeigt(value: 23)).isActive = true
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
            $0.leadingAnchor.constraint(equalTo: tempBackgroundView.leadingAnchor, constant: Terminal.convertWidth(value: 24)).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 254)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeigt(value: 186)).isActive = true
            $0.bottomAnchor.constraint(equalTo: tempBackgroundView.bottomAnchor).isActive = true
        }
    }
    @objc func joinButtonDidTap() {
//        presenter?.joinButtonDidTap(studyID: studyInfo!.id, message: "테스트신청매세지~~")
        TerminalAlertMessage.show()
    }
}

extension StudyDetailView: StudyDetailViewProtocol {
    func studyJoinResult(message: String) {
        presenter?.showStudyListDetail(studyID: "\(studyInfo!.id)")
    }
    
    func showStudyDetail(with studyDetail: StudyDetail) {
        self.studyInfo = studyDetail
        userData = studyDetail.participate
        state = StudyDetailViewState.init(rawValue: studyDetail.authority)!
        memberView.collectionView.reloadData()
        parentView?.setting()
    }
    
    func showError() {
        
    }
    
    func showLoading() {
        
    }
    
    func hideLoading() {
        
    }
}

extension StudyDetailView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = memberView.collectionView.dequeueReusableCell(withReuseIdentifier: MemberCollectionViewCell.identifier, for: indexPath) as! MemberCollectionViewCell
        cell.profileImage.image = #imageLiteral(resourceName: "leehi")
        cell.nickname.text = "이하이"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
}
