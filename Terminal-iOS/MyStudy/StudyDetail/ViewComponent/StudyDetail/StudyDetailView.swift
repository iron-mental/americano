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

final class StudyDetailView: UIViewController {
  
    // state
    var presenter: StudyDetailPresenterProtocol?
    weak var parentView: MyStudyDetailViewProtocol?
  
    var state: StudyDetailViewState = .member {
        didSet {
            attribute()
        }
    }
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
    var studyTitle: String? {
        didSet {
            self.title = studyTitle
        }
    }
    
    var userData: [Participate] = []
    let joinProgressCatTapGesture = UITapGestureRecognizer(target: self,
                                                           action: #selector(modifyJoinButtonDidTap))
    // UI
    let appearance = UINavigationBarAppearance()
    let scrollView = UIScrollView()
    let tempBackgroundView = UIView()
    let joinButton = UIButton()
    let categoryLabel = UILabel()
    let memberView = MemeberView()
    let mainImageView = MainImageView(frame: CGRect.zero)
    let snsIconsView = StudyDetailSNSView()
    let mapView = NMFMapView()
    let joinProgressCat = AnimationView(name: "14476-rainbow-cat-remix")
    let studyPlanView = TitleWithContentView()
    let timeView = TitleWithContentView()
    let locationView = TitleWithContentView()
    let studyIntroduceView = TitleWithContentView()
    let moreButton = UIBarButtonItem()
    
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
        appearance.do {
            $0.configureWithTransparentBackground()
            $0.backgroundColor = .appColor(.terminalBackground)
        }
        navigationController?.do {
            $0.navigationBar.standardAppearance = appearance
            $0.navigationBar.standardAppearance.configureWithTransparentBackground()
            $0.navigationBar.backgroundColor = .appColor(.terminalBackground)
        }
        navigationItem.do {
            $0.rightBarButtonItems = [moreButton]
            $0.largeTitleDisplayMode = .always
        }
        moreButton.do {
            $0.image = UIImage(systemName: "ellipsis")?.withConfiguration(UIImage.SymbolConfiguration(weight: .regular))
            $0.target = self
            $0.action = #selector(moreButtonAction)
        }
        
        view.do {
            $0.backgroundColor = UIColor.appColor(.terminalBackground)
        }
        
        tempBackgroundView.do {
            $0.backgroundColor = UIColor.appColor(.terminalBackground)
        }
        
        mainImageView.do {
            $0.isUserInteractionEnabled = false
            $0.contentMode = .scaleAspectFit
            $0.layer.masksToBounds = true
            guard let imageURL = studyInfo?.image else { return }
            if imageURL.isEmpty {
                $0.image = nil
                $0.backgroundColor = .systemGray5
                $0.defaultStudyImage()
            } else {
                $0.subviews.forEach {
                    $0.removeFromSuperview()
                }
                $0.kf.setImage(with: URL(string: imageURL),
                               options: [.requestModifier(RequestToken.token())])
                $0.tintColor = .none
                $0.contentMode = .scaleAspectFill
            }
        }
        
        snsIconsView.do {
            [ $0.notion, $0.evernote, $0.web ]
                .forEach { $0.addTarget(self,
                                        action: #selector(snsButtonDidTap(_:)),
                                        for: .touchUpInside) }
        }
        
        joinButton.do {
            $0.tag = 0
            if state == .none || state == .reject {
                $0.isHidden = false
                $0.setTitle("스터디 참여하기", for: .normal)
                $0.titleLabel?.dynamicFont(fontSize: 13, weight: .bold)
                $0.setTitleColor(.white, for: .normal)
                $0.backgroundColor = UIColor.appColor(.mainColor)
                $0.layer.cornerRadius = 10
                $0.clipsToBounds = false
                $0.removeTarget(self, action: #selector(modifyJoinButtonDidTap), for: .touchUpInside)
                $0.addTarget(self, action: #selector(joinButtonDidTap), for: .touchUpInside)
            } else if state == .applier {
                $0.isHidden = false
                $0.setTitle("가입 진행중", for: .normal)
                $0.titleLabel?.dynamicFont(fontSize: 13, weight: .bold)
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
        }
        
        categoryLabel.do {
            $0.textColor = .appColor(.mainColor)
            $0.text = studyInfo?.category ?? ""
            $0.backgroundColor = UIColor.appColor(.terminalBackground)
            $0.dynamicFont(fontSize: 14, weight: .regular)
        }
        
        memberView.do {
            $0.collectionView.delegate = self
            $0.collectionView.dataSource = self
        }
        
        studyPlanView.do {
            $0.title.text = "스터디 진행"
            $0.contentText = ["스터디 진행", String(studyInfo?.progress ?? "")]
        }
        
        timeView.do {
            $0.title.text = "시간"
            $0.contentText = ["시간", String(studyInfo?.studyTime ?? "")]
        }
        
        locationView.do {
            var detailAddress = ""
            if let item = studyInfo?.location.locationDetail {
                detailAddress = item
            }
            $0.title.text = "장소"
            $0.contentText = ["장소", String(studyInfo?.location.addressName ?? "") + " " + detailAddress]
        }
        
        mapView.do {
            if let location = studyInfo?.location {
                $0.moveCamera(NMFCameraUpdate(scrollTo: NMGLatLng(lat: Double(location.latitude)!, lng: Double(location.longitude)!), zoomTo: 17))
            }
            $0.isUserInteractionEnabled = false
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
        
        [mainImageView, joinButton, snsIconsView, studyIntroduceView, categoryLabel, memberView, studyPlanView, timeView, locationView, mapView, joinProgressCat].forEach { tempBackgroundView.addSubview($0) }
        
        scrollView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            $0.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
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
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeight(value: 169)).isActive = true
        }
        snsIconsView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: mainImageView.bottomAnchor,
                                    constant: 5).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                        constant: 15).isActive = true
            $0.trailingAnchor.constraint(equalTo: joinButton.leadingAnchor).isActive = true
            $0.heightAnchor.constraint(equalTo: snsIconsView.heightAnchor).isActive = true
        }
        joinButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: snsIconsView.centerYAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: tempBackgroundView.trailingAnchor,
                                         constant: -Terminal.convertWidth(value: 24)).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 150)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeight(value: 36)).isActive = true
        }
        studyIntroduceView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: snsIconsView.bottomAnchor, constant: Terminal.convertHeight(value: 23)).isActive = true
            $0.leadingAnchor.constraint(equalTo: tempBackgroundView.leadingAnchor, constant: Terminal.convertWidth(value: 24)).isActive = true
            $0.trailingAnchor.constraint(equalTo: tempBackgroundView.trailingAnchor, constant: -Terminal.convertWidth(value: 24)).isActive = true
            $0.bottomAnchor.constraint(equalTo: studyIntroduceView.label.bottomAnchor).isActive = true
        }
        categoryLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: studyIntroduceView.title.centerYAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: studyIntroduceView.trailingAnchor).isActive = true
        }
        memberView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: studyIntroduceView.bottomAnchor,
                                    constant: Terminal.convertHeight(value: 23)).isActive = true
            $0.leadingAnchor.constraint(equalTo: tempBackgroundView.leadingAnchor,
                                        constant: Terminal.convertWidth(value: 24)).isActive = true
            $0.trailingAnchor.constraint(equalTo: tempBackgroundView.trailingAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: $0.collectionView.bottomAnchor).isActive = true
        }
        studyPlanView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: memberView.bottomAnchor,
                                    constant: Terminal.convertHeight(value: 23)).isActive = true
            $0.leadingAnchor.constraint(equalTo: tempBackgroundView.leadingAnchor,
                                        constant: Terminal.convertWidth(value: 24)).isActive = true
            $0.trailingAnchor.constraint(equalTo: tempBackgroundView.trailingAnchor,
                                         constant: -Terminal.convertWidth(value: 24)).isActive = true
            $0.bottomAnchor.constraint(equalTo: studyPlanView.label.bottomAnchor).isActive = true
        }
        timeView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: studyPlanView.bottomAnchor,
                                    constant: Terminal.convertHeight(value: 23)).isActive = true
            $0.leadingAnchor.constraint(equalTo: tempBackgroundView.leadingAnchor,
                                        constant: Terminal.convertWidth(value: 24)).isActive = true
            $0.trailingAnchor.constraint(equalTo: tempBackgroundView.trailingAnchor,
                                         constant: -Terminal.convertWidth(value: 24)).isActive = true
            $0.bottomAnchor.constraint(equalTo: timeView.label.bottomAnchor).isActive = true
        }
        locationView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: timeView.bottomAnchor,
                                    constant: Terminal.convertHeight(value: 23)).isActive = true
            $0.leadingAnchor.constraint(equalTo: tempBackgroundView.leadingAnchor,
                                        constant: Terminal.convertWidth(value: 24)).isActive = true
            $0.trailingAnchor.constraint(equalTo: tempBackgroundView.trailingAnchor,
                                         constant: -Terminal.convertWidth(value: 24)).isActive = true
            $0.bottomAnchor.constraint(equalTo: locationView.label.bottomAnchor).isActive = true
        }
        mapView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: locationView.bottomAnchor, constant: Terminal.convertHeight(value: 23)).isActive = true
            $0.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 254)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeight(value: 186)).isActive = true
            $0.bottomAnchor.constraint(equalTo: tempBackgroundView.bottomAnchor).isActive = true
        }
        joinProgressCat.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: joinButton.centerYAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: joinButton.leadingAnchor, constant: 5).isActive = true
            $0.widthAnchor.constraint(equalTo: joinButton.widthAnchor, multiplier: 0.45).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeight(value: 72)).isActive = true
        }
    }
    
    @objc func joinButtonDidTap() {
        TerminalAlertMessage.show(controller: self, type: .StudyApplyView)
        TerminalAlertMessage.getRightButton().addTarget(self, action: #selector(studyApplyMessageEndEditing), for: .touchUpInside)
    }
    
    @objc func modifyJoinButtonDidTap() {
        guard let id = studyID else { return }
        presenter?.modifyStudyMessageButtonDidTap(studyID: id)
    }
    
    @objc func studyApplyMessageEndEditing() {
        TerminalAlertMessage.dismiss()
        if let contentViewController = TerminalAlertMessage.alert.value(forKey: "contentViewController"),
           let castContentViewController = contentViewController as? UIViewController {
            if let alertView = castContentViewController.view {
                if let messageView = alertView as? StudyApplyMessageView {
                    guard let message =  messageView.editMessageTextView.text else { return }
                    presenter?.joinButtonDidTap(studyID: studyID!, message: message)
                }
            }
        }
    }
    
    @objc func snsButtonDidTap(_ sender: UIButton) {
        var url = ""
        switch sender.tag {
        case 0:
            guard let notion = studyInfo?.snsNotion else { return }
            url = notion
        case 1:
            guard let evernote = studyInfo?.snsEvernote else { return }
            url = evernote
        case 2:
            guard let web = studyInfo?.snsWeb else { return }
            url = web
        default: break
        }
        presenter?.snsButtonDidTap(url: url)
    }
    
    @objc func moreButtonAction() {
        let alert =  UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let reportStudy =  UIAlertAction(title: "신고하기", style: .default) {_ in self.reportButtonDidTap() }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        [reportStudy, cancel].forEach { alert.addAction($0) }
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            if let popoverController = alert.popoverPresentationController {
                popoverController.sourceView = self.view
                popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
                popoverController.permittedArrowDirections = []
                self.present(alert, animated: true, completion: nil)
                
            }
        } else {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func reportButtonDidTap() {
        TerminalAlertMessage.show(controller: self, type: .ReportContentView)
        TerminalAlertMessage.getRightButton().addTarget(self, action: #selector(reportButtonConfirmed), for: .touchUpInside)
    }
    
    @objc func reportButtonConfirmed() {
        TerminalAlertMessage.dismiss()
        if let contentViewController = TerminalAlertMessage.alert.value(forKey: "contentViewController"),
           let castContentViewController = contentViewController as? UIViewController {
            if let alertView = castContentViewController.view {
                if let messageView = alertView as? AlertReportContentView {
                    guard let message =  messageView.editMessageTextView.text,
                          let id = studyInfo?.id else { return }
                    presenter?.reportConfirmButtonDidTap(studyID: id, reportMessage: message)
                }
            }
        }
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
        
        memberView.totalMember.text = "\(userData.count) 명"
        
        if let notion = studyDetail.snsNotion,
           let evernote = studyDetail.snsEvernote,
           let web = studyDetail.snsWeb {
            snsList.updateValue(notion, forKey: SNSState.notion.rawValue)
            snsList.updateValue(evernote, forKey: SNSState.evernote.rawValue)
            snsList.updateValue(web, forKey: SNSState.web.rawValue)
        }
        
        memberView.collectionView.reloadData()
        self.snsIconsView.addstack(snsList: snsList)
        attribute()
        parentView?.setting(caller: self)
    }
    
    func showError(message: String) {
        self.hideLoading()
        if message == "공백은 허용되지 않습니다" {
            showToast(controller: self, message: message, seconds: 1)
        } else {
            mapView.removeFromSuperview()
            self.state = .none
            parentView?.setting(caller: self)
            self.view.isHidden = true
            showToast(controller: self, message: message, seconds: 1) {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func showLoading() {
        LoadingRainbowCat.show(caller: self)
    }
    
    func hideLoading() {
        LoadingRainbowCat.hide(caller: self)
    }
    
    func showReportResult(message: String) {
        showToast(controller: self, message: message, seconds: 1)
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
        if state == .host || state == .member {
            presenter?.memberDidTap(userID: userData[indexPath.row].userID)
        } else {
            showToast(controller: self, message: "멤버 프로필은 스터디 참여 후에 \n볼 수 있습니다.", seconds: 1)
        }
    }
}
