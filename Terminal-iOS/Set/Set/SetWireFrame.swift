//
//  SetWireFrame.swift
//  Terminal-iOS
//
//  Created by once on 2020/10/07.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit
import SafariServices

class SetWireFrame: SetWireFrameProtocol {
    static func setCreateModule() -> UIViewController {
        let view: SetViewProtocol = SetView()
        let presenter: SetPresenterProtocol & SetInteractorOutputProtocol = SetPresenter()
        let interactor: SetInteractortInputProtocol & SetRemoteDataManagerOutputProtocol = SetInteractor()
        let wireFrame: SetWireFrameProtocol = SetWireFrame()
        let remoteDataManager: SetRemoteDataManagerInputProtocol = SetRemoteManager()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        interactor.remoteDataManager = remoteDataManager
        
        remoteDataManager.interactor = interactor
        
        if let view = view as? SetView {
            return view
        } else {
            return UIViewController()
        }
    }
    
    func presentProfileDetailScreen(from view: SetViewProtocol) {
        let profileDetailView = ProfileDetailWireFrame.createModule()

        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(profileDetailView, animated: true)
        }
    }
    
    func presentUserWithdrawal(from view: SetViewProtocol) {
        let userWithdrawalView = UserWithdrawalWireFrame.createModule()

        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(userWithdrawalView, animated: true)
        }
    }
    
    func replaceRootViewToIntroView(from view: SetViewProtocol) {
        guard let window = UIApplication.shared.windows.first else { return }
        let view = HomeView()
        let home = UINavigationController(rootViewController: view)
        window.replaceRootViewController(home, animated: true, completion: nil)
    }
    
    func goToSettingApp() {
        if let bundleIdentifier = Bundle.main.bundleIdentifier,
           let appSettings = URL(string: UIApplication.openSettingsURLString + bundleIdentifier) {
            if UIApplication.shared.canOpenURL(appSettings) {
                UIApplication.shared.open(appSettings)
            }
        }
    }
    
    func goToInquiryWeb(from view: SetViewProtocol) {
        let email = "mailto:team.ironmental@gmail.com"
        if let url = URL(string: email) {
          if #available(iOS 10.0, *) {
            UIApplication.shared.open(url)
          } else {
            UIApplication.shared.openURL(url)
          }
        }
    }
    
    func goToPrivacyWeb(from view: SetViewProtocol) {
        guard let url = URL(string: "https://www.terminal-study.tk/privacy") else { return }
        let webView = SFSafariViewController(url: url)
        if let introview = view as? UIViewController {
            introview.present(webView, animated: true, completion: nil)
        }
    }
    
    func goToTermsOfServiceWeb(from view: SetViewProtocol) {
        guard let url = URL(string: "https://www.terminal-study.tk/terms") else { return }
        let webView = SFSafariViewController(url: url)
        if let introview = view as? UIViewController {
            introview.present(webView, animated: true, completion: nil)
        }
    }
}
