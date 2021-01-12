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
    
    var address1depth: [Address] = [] {
        didSet {
            self.locationCollectionView.reloadData()
        }
    }
    
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
        locationCollectionView.do {
            $0.backgroundColor = .systemBackground
            $0.register(LocationCell.self, forCellWithReuseIdentifier: LocationCell.cellID)
            $0.delegate = self
            $0.dataSource = self
        }
    }
    
    private func layout() {
        self.view.addSubview(locationCollectionView)
        self.locationCollectionView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
            $0.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        }
    }
}

extension LocationModifyView: LocationModifyViewProtocol {
    func showAddress(address: [Address]) {
        self.address1depth = address
    }
}

extension LocationModifyView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return address1depth.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width * 0.27,
                              height: UIScreen.main.bounds.width * 0.13)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = locationCollectionView.dequeueReusableCell(withReuseIdentifier: LocationCell.cellID, for: indexPath) as! LocationCell
        
        let data = address1depth[indexPath.row].si
        cell.setData(data: data)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
