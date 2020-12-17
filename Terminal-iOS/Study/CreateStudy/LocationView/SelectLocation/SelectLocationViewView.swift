//
//  SelectLocationViewViewController.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/09/27.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import NMapsMap

protocol selectLocationDelegate {
    func passLocation(location: StudyDetailLocationPost)
}

class SelectLocationView: UIViewController {
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    var presenter: SelectLocationPresenterProtocol?
    let pin = UIImageView()
    var task: DispatchWorkItem?
    var mapView = NMFMapView()
    var bottomView = BottomView()
    var location: StudyDetailLocationPost?
    var preventPlaceNameFlag = true
    var delegate: selectLocationDelegate?
    var keyboardHeight: CGFloat = 0.0
    
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
        bottomView.textField.becomeFirstResponder()
        mapView.moveCamera(NMFCameraUpdate(scrollTo: NMGLatLng(lat: Double(location!.lat), lng: Double(location!.lng)),zoomTo: 17))
        location?.lng = mapView.cameraPosition.target.lng
        location?.lat = mapView.cameraPosition.target.lat
        presenter?.getAddress(item: location!)
    }
    override func viewWillAppear(_ animated: Bool) {
        preventPlaceNameFlag = isBeingPresented
    }
    
    @objc func keyboardWillShow(notification:NSNotification) {
        let userInfo:NSDictionary = notification.userInfo! as NSDictionary
        let keyboardFrame:NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        keyboardHeight = keyboardRectangle.height
    }
    
    @objc func keyboardWillHide() {
        
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
        
        mapView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
        }
        pin.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerXAnchor.constraint(equalTo: mapView.centerXAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: mapView.centerYAnchor).isActive = true
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
        if let detailAddress = bottomView.detailAddress.text {
            location?.detailAddress = detailAddress
        }
        delegate?.passLocation(location: location!)
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
                    location?.category = ""
                    presenter?.getAddress(item: location!)
                
            })
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: task!)
    }
    
    func mapView(_ mapView: NMFMapView, cameraWillChangeByReason reason: Int, animated: Bool) {
        self.view.endEditing(true)
        task?.cancel()
        pin.alpha = 0.5
        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            self.pin.transform = CGAffineTransform(translationX: 0, y: -10)
        })
    }
    func mapView(_ mapView: NMFMapView, cameraDidChangeByReason reason: Int, animated: Bool) {
        print(location?.placeName)
    }
}

extension SelectLocationView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}

extension SelectLocationView: SelectLocationViewProtocol {
    func setViewWithResult(item: StudyDetailLocationPost) {
            bottomView.Address.text = item.address
            location = item
    }
}
