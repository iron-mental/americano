//
//  SelectLocationViewViewController.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/27.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import NMapsMap

class SelectLocationView: UIViewController {
    var presenter: SelectLocationPresenterProtocol?
    let pin = UIImageView()
    var task: DispatchWorkItem?
    var mapView = NMFMapView()
    var bottomView = BottomView()
    var keyboardHeight: CGFloat = 0
    var location: searchLocationResult?
    var preventPlaceNameFlag = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
        bottomView.textField.delegate = self
        bottomView.detailAddress.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    override func viewDidAppear(_ animated: Bool) {
        print("이거 실화야??",isBeingPresented)
        bottomView.textField.becomeFirstResponder()
        mapView.moveCamera(NMFCameraUpdate(scrollTo: NMGLatLng(lat: Double(location!.lat), lng: Double(location!.lng))))
    }
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            keyboardHeight = keyboardSize.height
            bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -keyboardHeight).isActive = true
            view.setNeedsLayout()
            view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        bottomView.frame.origin.y = UIScreen.main.bounds.height - bottomView.frame.height
    }
    
    func attribute() {
        mapView = NMFMapView(frame: view.frame)
        mapView.do {
            $0.mapType = .basic
            $0.symbolScale = 0.7
            $0.addCameraDelegate(delegate: self)
        }
        pin.do {
            $0.image = #imageLiteral(resourceName: "marker")
        }
        bottomView.do {
            $0.completeButton.addTarget(self, action: #selector(didCompleteButtonClicked), for: .touchUpInside)
            $0.Address.text = location?.address
        }
    }
    
    func layout() {
        [mapView, pin, bottomView].forEach { view.addSubview($0) }
        
        pin.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            $0.widthAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 35)).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertWidth(value: 50)).isActive = true
        }
        bottomView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            $0.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            $0.heightAnchor.constraint(equalToConstant: Terminal.convertHeigt(value: 202)).isActive = true
        }
    }
    
    @objc func didCompleteButtonClicked() {
        //추후에 로딩이미지 줍시다.
        presentingViewController?.dismiss(animated: false)
        self.presentingViewController?.presentingViewController?.dismiss(animated: false)
    }
}

extension SelectLocationView: NMFMapViewCameraDelegate {
    func mapViewCameraIdle(_ mapView: NMFMapView) {
        task = DispatchWorkItem { [self] in
            self.pin.alpha = 1
            //추후에 여기서 mapView.cameraPosition.target.lat 으로 좌표알아내서 쏘면 됨
            UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                self.pin.transform = CGAffineTransform(translationX: 0, y: 0)
                location?.lng = mapView.cameraPosition.target.lng
                location?.lat = mapView.cameraPosition.target.lat
                if preventPlaceNameFlag == true {
                    presenter?.getAddress(item: location!)
                }
                preventPlaceNameFlag = true
            })
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: task!)
    }
    
    func mapView(_ mapView: NMFMapView, cameraWillChangeByReason reason: Int, animated: Bool) {
        self.view.endEditing(true)
        location?.placeName = nil
        task?.cancel()
        pin.alpha = 0.5
        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            self.pin.transform = CGAffineTransform(translationX: 0, y: -10)
        })
    }
}

extension SelectLocationView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}

extension SelectLocationView: SelectLocationViewProtocol {
    func setViewWithResult(item: searchLocationResult) {

        if item.address != "" {
            bottomView.Address.text = item.address
        }
    }
}
