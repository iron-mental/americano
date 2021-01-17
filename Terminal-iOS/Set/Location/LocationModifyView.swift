//
//  LocationModifyView.swift
//  Terminal-iOS
//
//  Created by once on 2021/01/12.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit
import Then

class LocationModifyView: UIViewController {
    var presenter: LocationModifyPresenterProtocol?
    
    var addressState: AddressState = .sido
    var address1depth: [Address] = []
    var address2depth: [String] = []
    
    var the1depth: String = ""          { didSet { attribute() } }
    var the2depth: String = ""          { didSet { attribute() } }
    var selectedSegmentIndex: Int = 0   { didSet { attribute() } }
    
    lazy var locationLabel = UILabel()
    lazy var locationTab = UISegmentedControl(items: ["광역시도","시군구"])
    lazy var completeButton = UIButton()
    
    let locationCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    // MARK: viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
        presenter?.viewDidLoad()
    }
    
    // MARK: Attribute set
    
    private func attribute() {
        self.do {
            $0.title = "활동지역 설정"
            $0.view.backgroundColor = .appColor(.terminalBackground)
        }
        self.locationTab.do {
            $0.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 16),
                                       .foregroundColor: UIColor.gray], for: .normal)
            $0.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 18),
                                       .foregroundColor: UIColor.white], for: .selected)
            $0.selectedSegmentIndex = self.selectedSegmentIndex
            $0.layer.cornerRadius = 0
            $0.backgroundColor = .clear
            $0.clearBG()
            $0.selectedSegmentTintColor = .clear
            $0.addTarget(self, action: #selector(indexChanged(_:)), for: .valueChanged)
        }
        self.locationLabel.do {
            $0.textAlignment = .center
            $0.textColor = .white
            $0.text = self.the1depth + " " + self.the2depth
        }
        self.locationCollectionView.do {
            $0.backgroundColor = .appColor(.terminalBackground)
            $0.register(LocationCell.self, forCellWithReuseIdentifier: LocationCell.cellID)
            $0.delegate = self
            $0.dataSource = self
        }
        self.completeButton.do {
            $0.backgroundColor = .appColor(.mainColor)
            $0.setTitle("수정완료", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.layer.cornerRadius = 10
            $0.addTarget(self, action: #selector(completeModify), for: .touchUpInside)
        }
    }
    
    // MARK: Layout set
    
    private func layout() {
        self.view.addSubview(locationTab)
        self.view.addSubview(locationLabel)
        self.view.addSubview(locationCollectionView)
        self.view.addSubview(completeButton)
        
        self.locationLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
            $0.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        }
        self.locationTab.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.locationLabel.bottomAnchor, constant: 10).isActive = true
            $0.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
            $0.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 3 * 2).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 60).isActive = true
        }
        self.locationCollectionView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.locationTab.bottomAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
            $0.bottomAnchor.constraint(equalTo: self.completeButton.topAnchor).isActive = true
        }
        
        self.completeButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 25).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -25).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 60).isActive = true
        }
    }
    
    @objc func completeModify() {
        let sido = self.the1depth
        let sigungu = self.the2depth
        presenter?.completeModify(sido: sido, sigungu: sigungu)
    }
    
    
    @objc func indexChanged(_ sender: UISegmentedControl) {
        let selectedIndex = sender.selectedSegmentIndex
        
        // 0번째 탭을 클릭시 시군구의 데이터는 모두 지움
        if selectedIndex == 0 {
            self.addressState = .sido
            self.address2depth.removeAll()
            self.the1depth = ""
            self.the2depth = ""
            self.selectedSegmentIndex = 0
            self.locationCollectionView.reloadData()
        } else if selectedIndex == 1 {
            self.selectedSegmentIndex = 0
            self.showToast(controller: self, message: "광역시도를 먼저 선택해주세요.", seconds: 1)
        }
    }
}

extension LocationModifyView: LocationModifyViewProtocol {
    func showAddress(address: [Address]) {
        self.address1depth = address
        self.locationCollectionView.reloadData()
    }
    
    func modifyResultHandle(result: Bool, message: String) {
        if result {
            let parent = self.navigationController?.viewControllers[1] as? ProfileDetailView
            self.navigationController?.popViewController(animated: true, completion: {
                parent?.showToast(controller: parent!, message: "활동 지역 수정 완료", seconds: 1)
                parent?.presenter?.viewDidLoad()
            })
        } else {
            // error handle
        }
    }
}

extension LocationModifyView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return addressState == .sido ? address1depth.count : address2depth.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width * 0.27,
                      height: UIScreen.main.bounds.width * 0.13)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = locationCollectionView.dequeueReusableCell(withReuseIdentifier: LocationCell.cellID, for: indexPath) as! LocationCell
        
        // 주소 상태에 따른 뷰 재사용
        switch addressState {
        case .sido:
            let data = address1depth[indexPath.row].sido
            cell.setData(data: data)
        case .sigungu:
            let data = address2depth[indexPath.row]
            cell.setData(data: data)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // 광역시도 item 클릭시 탭 상태변경 및 시군구 셋팅
        if addressState == .sido {
            let gungu = address1depth[indexPath.row].sigungu
            self.address2depth = gungu
            
            self.the1depth = address1depth[indexPath.row].sido
            
            self.addressState = .sigungu
            self.selectedSegmentIndex = 1
            self.locationTab.setEnabled(true, forSegmentAt: 1)
            self.locationCollectionView.reloadData()
        } else {
            let gungu = address2depth[indexPath.row]
            self.the2depth = gungu
        }
    }
}
