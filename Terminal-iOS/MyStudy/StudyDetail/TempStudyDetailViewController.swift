//
//  TempStudyDetailViewController.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/10/29.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

class TempStudyDetailViewController: UIViewController {
    
    var scrollView = UIScrollView()
    var tempBackgroundView = UIView()
    let picker = UIImagePickerController()
    var mainImageViewTapGesture = UITapGestureRecognizer()
    
    var mainImageView = MainImageView(frame: CGRect.zero)
    var snsIconsView = SNSIconsView(frame: CGRect.zero)
    var studyIntroduceLabel = StudyIntroduceLabel()
    var memberView = MemeberView()
    
    
    var testView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize = CGSize(width: scrollView.contentSize.width, height: 580)
        attribute()
        layout()
    }
    
    func attribute() {
        mainImageViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(didimageViewClicked))
        tempBackgroundView.do {
            $0.backgroundColor = UIColor.appColor(.terminalBackground)
        }
        mainImageView.do {
            $0.addGestureRecognizer(mainImageViewTapGesture)
        }
        testView.do {
            $0.backgroundColor = UIColor.appColor(.terminalBackground)
        }
        memberView.do {
            $0.collectionView.delegate = self
            $0.collectionView.dataSource = self
        }
    }
    
    func layout() {
        view.addSubview(scrollView)
        scrollView.addSubview(tempBackgroundView)
        
        [mainImageView, snsIconsView, studyIntroduceLabel, memberView, testView].forEach { tempBackgroundView.addSubview($0) }
        
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
            $0.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: Terminal.convertHeigt(value: 26)).isActive = true
            $0.leadingAnchor.constraint(equalTo: tempBackgroundView.leadingAnchor, constant: Terminal.convertWidth(value: 24)).isActive = true
            $0.trailingAnchor.constraint(equalTo: tempBackgroundView.trailingAnchor, constant: -Terminal.convertWidth(value: 24)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 22)).isActive = true
        }
        studyIntroduceLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: snsIconsView.bottomAnchor, constant: Terminal.convertHeigt(value: 9)).isActive = true
            $0.leadingAnchor.constraint(equalTo: tempBackgroundView.leadingAnchor, constant: Terminal.convertWidth(value: 24)).isActive = true
            $0.trailingAnchor.constraint(equalTo: tempBackgroundView.trailingAnchor, constant: -Terminal.convertWidth(value: 24)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 125).isActive = true
        }
        memberView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: studyIntroduceLabel.bottomAnchor, constant: Terminal.convertHeigt(value: 32)).isActive = true
            $0.leadingAnchor.constraint(equalTo: tempBackgroundView.leadingAnchor, constant: Terminal.convertWidth(value: 24)).isActive = true
            $0.trailingAnchor.constraint(equalTo: tempBackgroundView.trailingAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeigt(value: 200)).isActive = true
        }
        
        
        
        
        testView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerXAnchor.constraint(equalTo: tempBackgroundView.centerXAnchor).isActive = true
            $0.topAnchor.constraint(equalTo: mainImageView.bottomAnchor,constant: 500).isActive = true
            $0.widthAnchor.constraint(equalTo: tempBackgroundView.widthAnchor, multiplier: 3/4).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 100).isActive = true
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
}

extension TempStudyDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = memberView.collectionView.dequeueReusableCell(withReuseIdentifier: MemberCollectionViewCell.identifier, for: indexPath) as! MemberCollectionViewCell
        cell.profileImage.image = #imageLiteral(resourceName: "leehi")
        cell.nickname.text = "이하이"
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
