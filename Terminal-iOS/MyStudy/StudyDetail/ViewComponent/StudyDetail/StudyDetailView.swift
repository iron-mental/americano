//
//  TempStudyDetailViewController.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/10/29.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import NMapsMap
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
    var keyValue: Int?
    var studyInfo: StudyDetail?
    var scrollView = UIScrollView()
    var tempBackgroundView = UIView()
    let picker = UIImagePickerController()
    var mainImageViewTapGesture = UITapGestureRecognizer()
    
    var mainImageView = MainImageView(frame: CGRect.zero)
    var snsIconsView = SNSIconsView(frame: CGRect.zero)
    lazy var studyIntroduceView = TitleWithContentView(state: state)
    var memberView = MemeberView()
    lazy var studyPlanView = TitleWithContentView(state: state)
    lazy var timeView = TitleWithContentView(state: state)
    lazy var locationView = TitleWithContentView(state: state)
    var mapView = NMFMapView()
    var joinButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        attribute()
        layout()
        presenter?.showStudyListDetail(keyValue: "\(keyValue!)")
    }
    
    func attribute() {
        mainImageViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(didimageViewClicked))
        view.do {
            $0.backgroundColor = UIColor.appColor(.terminalBackground)
        }
        tempBackgroundView.do {
            $0.backgroundColor = UIColor.appColor(.terminalBackground)
        }
        mainImageView.do {
            $0.addGestureRecognizer(mainImageViewTapGesture)
            $0.image = #imageLiteral(resourceName: "swiftBackground")
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
        
        //studyIntroduceView, studyPlanView, timeView, timeView
        studyIntroduceView.do {
            $0.titleHidden()
            $0.contentText = ["",String(studyInfo?.introduce ?? "")]
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
            $0.title.text = "장소"
            $0.contentText = ["장소",  String(studyInfo?.location.addressName ?? "")]
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
            $0.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: Terminal.convertHeigt(value: 30)).isActive = true
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
            $0.topAnchor.constraint(equalTo: snsIconsView.bottomAnchor, constant: Terminal.convertHeigt(value: 9)).isActive = true
            $0.leadingAnchor.constraint(equalTo: tempBackgroundView.leadingAnchor, constant: Terminal.convertWidth(value: 24)).isActive = true
            $0.trailingAnchor.constraint(equalTo: tempBackgroundView.trailingAnchor, constant: -Terminal.convertWidth(value: 24)).isActive = true
            $0.bottomAnchor.constraint(equalTo: studyIntroduceView.label.isHidden == false ? studyIntroduceView.label.bottomAnchor : studyIntroduceView.textView.bottomAnchor ).isActive = true
        }
        memberView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: studyIntroduceView.bottomAnchor, constant: Terminal.convertHeigt(value: 30)).isActive = true
            $0.leadingAnchor.constraint(equalTo: tempBackgroundView.leadingAnchor, constant: Terminal.convertWidth(value: 24)).isActive = true
            $0.trailingAnchor.constraint(equalTo: tempBackgroundView.trailingAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeigt(value: 96)).isActive = true
        }
        studyPlanView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: memberView.bottomAnchor,constant: Terminal.convertHeigt(value: 30)).isActive = true
            $0.leadingAnchor.constraint(equalTo: tempBackgroundView.leadingAnchor, constant: Terminal.convertWidth(value: 24)).isActive = true
            $0.trailingAnchor.constraint(equalTo: tempBackgroundView.trailingAnchor, constant: -Terminal.convertWidth(value: 24)).isActive = true
            $0.bottomAnchor.constraint(equalTo: studyPlanView.label.isHidden == false ? studyPlanView.label.bottomAnchor : studyPlanView.textView.bottomAnchor ).isActive = true
        }
        timeView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: studyPlanView.bottomAnchor, constant: Terminal.convertHeigt(value: 30)).isActive = true
            $0.leadingAnchor.constraint(equalTo: tempBackgroundView.leadingAnchor, constant: Terminal.convertWidth(value: 24)).isActive = true
            $0.trailingAnchor.constraint(equalTo: tempBackgroundView.trailingAnchor, constant: -Terminal.convertWidth(value: 24)).isActive = true
            $0.bottomAnchor.constraint(equalTo: timeView.label.isHidden == false ? timeView.label.bottomAnchor : timeView.textView.bottomAnchor ).isActive = true
        }
        locationView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: timeView.bottomAnchor, constant: Terminal.convertHeigt(value: 30)).isActive = true
            $0.leadingAnchor.constraint(equalTo: tempBackgroundView.leadingAnchor, constant: Terminal.convertWidth(value: 24)).isActive = true
            $0.trailingAnchor.constraint(equalTo: tempBackgroundView.trailingAnchor, constant: -Terminal.convertWidth(value: 24)).isActive = true
            $0.bottomAnchor.constraint(equalTo: locationView.label.isHidden == false ? locationView.label.bottomAnchor : locationView.textView.bottomAnchor).isActive = true
        }
        mapView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: locationView.bottomAnchor, constant: Terminal.convertHeigt(value: 30)).isActive = true
            $0.leadingAnchor.constraint(equalTo: tempBackgroundView.leadingAnchor, constant: Terminal.convertWidth(value: 24)).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 254)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeigt(value: 186)).isActive = true
            $0.bottomAnchor.constraint(equalTo: tempBackgroundView.bottomAnchor).isActive = true
        }
    }
    @objc func didimageViewClicked() {
        let alert =  UIAlertController(title: "대표 사진 설정", message: nil, preferredStyle: .actionSheet)
        let library =  UIAlertAction(title: "사진앨범", style: .default) { (action) in self.openLibrary() }
        let camera =  UIAlertAction(title: "카메라", style: .default) { (action) in self.openCamera() }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(library)
        alert.addAction(camera)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    func openLibrary() {
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    func openCamera() {
        //시뮬에서 앱죽는거 에러처리 해야함
        picker.sourceType = .camera
        present(picker, animated: true, completion: nil)
    }
    @objc func joinButtonDidTap() {
        presenter?.joinButtonDidTap(studyID: studyInfo!.id, message: "테스트신청매ㅐㅔ세지~~")
    }
}

extension StudyDetailView: StudyDetailViewProtocol {
    func studyJoinResult(message: String) {
//        <#code#>
    }
    
    
    func showStudyDetail(with studyDetail: StudyDetail) {
        self.studyInfo = studyDetail
        
//        if studyDetail.image == "" || studyDetail.image == nil {
//            mainImageView.do {
//                $0.image = #imageLiteral(resourceName: "swift")
//            }
//        } else {
//            mainImageView.do {
//                guard let url = URL(string: studyDetail.image!) else { return }
//                $0.kf.setImage(with: url)
//            }
//        }
//
//        studyIntroduceView.do {
//            $0.contentText = ["","\(studyDetail.title)"]
//        }
//        studyPlanView.do {
//            $0.contentText = ["스터디 진행","\(studyDetail.title)"]
//        }
//        timeView.do {
//            $0.contentText = ["시간","\(studyDetail.studyTime)"]
//        }
//        locationView.do {
//            $0.contentText[1] = "\(studyDetail.location.addressName) \(studyDetail.location.placeName ?? "")"
//        }
        userData = studyDetail.participate
        state = StudyDetailViewState.init(rawValue: studyDetail.authority)!
        memberView.collectionView.reloadData()
        
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
//        return userData.count
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = memberView.collectionView.dequeueReusableCell(withReuseIdentifier: MemberCollectionViewCell.identifier, for: indexPath) as! MemberCollectionViewCell
//        print(userData[indexPath.row].image)
//        print(userData[indexPath.row].nickname)
//        cell.profileImage.kf.setImage(with: URL(string: userData[indexPath.row].image))
//        cell.nickname.text = userData[indexPath.row].nickname
        cell.profileImage.image = #imageLiteral(resourceName: "leehi")
        cell.nickname.text = "이하이"
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
}
