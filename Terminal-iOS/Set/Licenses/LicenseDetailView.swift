//
//  LicenseDetailView.swift
//  Terminal-iOS
//
//  Created by once on 2021/03/06.
//  Copyright © 2021 정재인. All rights reserved.
//

import UIKit

class LicenseDetailView: UIViewController {
    let library: String
    let descript = UITextView()
    
    init(library: String) {
        self.library = library
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
        
        if let descript = licenseDescript(library: self.library) {
            self.descript.text = descript
        }
    }
    
    private func attribute() {
        self.do {
            $0.navigationItem.largeTitleDisplayMode = .never
        }
        self.descript.do {
            $0.backgroundColor = .appColor(.terminalBackground)
            $0.textColor = .white
            $0.isEditable = false
            $0.isUserInteractionEnabled = true
            $0.dataDetectorTypes = .link
        }
    }
    
    private func layout() {
        self.view.addSubview(self.descript)
        self.descript.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        }
    }
    
    func licenseDescript(library: String) -> String? {
        let license = LibraryLicense()
        switch library {
        case "Alamofire":
            return license.alamofire
        case "Firebase/Analytics":
            return license.firebase
        case "Firebase/Crashlytics":
            return license.firebase
        case "Kingfisher":
            return license.kingfisher
        case "lottie-ios":
            return license.lottie
        case "NMapsMap":
            return license.nMapsMap
        case "SwiftyJSON":
            return license.swiftyJSON
        case "SwiftLint":
            return license.swiftLint
        case "SwiftKeychainWrapper":
            return license.swiftKeychainWrapper
        case "Then":
            return license.then
        default:
            return nil
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
