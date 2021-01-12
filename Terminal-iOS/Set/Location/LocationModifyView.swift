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
    
    var addressState: AddressState = .si
    var address1depth: [Address] = []
    var address2depth: [String] = []
    
    var selectedLoaction: String = "" {
        didSet {
            self.attribute()
        }
    }
    var the1depth: String = "" {
        didSet {
            self.selectedLoaction
                = self.the1depth + " " + self.the2depth
        }
    }
    var the2depth: String = "" {
        didSet {
            self.selectedLoaction
                = self.the1depth + " " + self.the2depth
        }
    }
    
    lazy var locationLabel = UILabel()
    lazy var completeButton = UIButton()
    let locationCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
        presenter?.viewDidLoad()
    }
    
    private func attribute() {
        self.locationLabel.do {
            $0.textColor = .white
            $0.text = self.selectedLoaction
        }
        self.locationCollectionView.do {
            $0.backgroundColor = .systemBackground
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
    
    private func layout() {
        self.view.addSubview(locationLabel)
        self.view.addSubview(locationCollectionView)
        self.view.addSubview(completeButton)
        
        self.locationLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        }
        
        self.locationCollectionView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.locationLabel.bottomAnchor, constant: 10).isActive = true
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
        let location = self.selectedLoaction
        presenter?.completeModify(location: location)
    }
}

extension LocationModifyView: LocationModifyViewProtocol {
    func showAddress(address: [Address]) {
        self.address1depth = address
        self.locationCollectionView.reloadData()
    }
}

extension LocationModifyView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return addressState == .si ? address1depth.count : address2depth.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width * 0.27,
                      height: UIScreen.main.bounds.width * 0.13)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = locationCollectionView.dequeueReusableCell(withReuseIdentifier: LocationCell.cellID, for: indexPath) as! LocationCell
        
        switch addressState {
        case .si:
            let data = address1depth[indexPath.row].si
            cell.setData(data: data)
        case .gunGu:
            let data = address2depth[indexPath.row]
            cell.setData(data: data)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if addressState == .si {
            let gungu = address1depth[indexPath.row].gunGu
            self.address2depth = gungu
            
            self.the1depth = address1depth[indexPath.row].si
            
            self.addressState = .gunGu
            self.locationCollectionView.reloadData()
        } else {
            let gungu = address2depth[indexPath.row]
            self.the2depth = gungu
        }
    }
}
