//
//  LoginView.swift
//  Terminal-iOS
//
//  Created by 정재인 on 2020/10/21.
//  Copyright © 2020 정재인. All rights reserved.
//

import UIKit

enum BeginState {
    case signUp
    case join
}

enum IntroViewState {
    case emailInput
    case pwdInput
    case nickname
}

class IntroView: UIViewController {
    var presenter: IntroPresenterProtocol?
    
    var leftButton = UIButton()
    var rightbutton = UIButton()
    var guideLabel = UILabel()
    var inputTextfield = UITextField()
    var beginState: BeginState?
    var introState: IntroViewState?
    var invalidLabel = UILabel()
    lazy var rightBarButton = UIBarButtonItem(customView: rightbutton)
    lazy var leftBarButton = UIBarButtonItem(customView: leftButton)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setting()
        attribute()
        layout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        inputTextfield.becomeFirstResponder()
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
    
    func setting() {
        switch introState {
        case .emailInput:
            self.guideLabel.text = "이메일을\n입력해 주세요"
            self.inputTextfield.placeholder = "abc1234@terminal.com"
            self.introState = .emailInput
            self.leftButton.setImage(UIImage(systemName: "xmark")?
                                        .withConfiguration(UIImage.SymbolConfiguration(weight: .bold)),
                                     for: .normal)
            self.rightbutton.setTitle("다음", for: .normal)
        case .pwdInput:
            self.guideLabel.text = self.beginState ==
                .join
                ? "로그인을 위해 \n계정의 비밀번호를\n입력해 주세요."
                : "사용하실 비밀번호를\n설정해 주세요"
            self.inputTextfield.do {
                $0.placeholder = "비밀번호"
                $0.isSecureTextEntry = true
            }
            self.introState = .pwdInput
            self.leftButton.setImage(UIImage(systemName: "chevron.left")?
                                        .withConfiguration(UIImage.SymbolConfiguration(weight: .bold)),
                                     for: .normal)
            self.beginState ==
                .join
                ? self.rightbutton.setTitle("완료", for: .normal)
                : self.rightbutton.setTitle("다음", for: .normal)
        case .nickname:
            self.guideLabel.text = "가입을 위해\n닉네임을 입력해 주세요"
            self.inputTextfield.placeholder = "추천 닉네임"
            self.introState = .nickname
            self.leftButton.setImage(#imageLiteral(resourceName: "back"), for: .normal)
            self.rightbutton.setTitle("완료", for: .normal)
        case .none:
            print("none")
        }
    }
    
    // MARK: Attribute
    
    func attribute() {
        self.do {
            $0.navigationItem.rightBarButtonItem = rightBarButton
            $0.navigationItem.leftBarButtonItem = leftBarButton
            $0.view.backgroundColor = .appColor(.terminalBackground)
        }
        inputTextfield.do {
            $0.dynamicFont(fontSize: 15, weight: .regular)
            $0.clearButtonMode = .always
            $0.delegate = self
        }
        leftButton.do {
            UIImage(systemName: "books.vertical")?.withConfiguration(UIImage.SymbolConfiguration(weight: .light))
            $0.tintColor = .white
            $0.addTarget(self, action: #selector(didClickedBackButon), for: .touchUpInside)
        }
        rightbutton.do {
            $0.titleLabel?.dynamicFont(fontSize: 16, weight: .bold)
            $0.tintColor = .white
            $0.addTarget(self, action: #selector(didClickedNextButton), for: .touchUpInside)
        }
        guideLabel.do {
            $0.numberOfLines = 0
            $0.dynamicFont(fontSize: 23, weight: .bold)
        }
        invalidLabel.do {
            $0.numberOfLines = 0
            $0.textColor = .systemRed
        }
    }
    
    // MARK: Layout
    
    func layout() {
        [inputTextfield, guideLabel, invalidLabel ].forEach { view.addSubview($0) }
        
        inputTextfield.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -70).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Terminal.convertWidth(value: 40)).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Terminal.convertWidth(value: 40)).isActive = true
        }
        guideLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.bottomAnchor.constraint(equalTo: inputTextfield.topAnchor, constant: -(20/667) * UIScreen.main.bounds.height).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: (33/375) * UIScreen.main.bounds.width).isActive = true
        }
        invalidLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: inputTextfield.bottomAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: inputTextfield.leadingAnchor).isActive = true
        }
    }
    
    @objc func didClickedBackButon() {
        self.inputTextfield.endEditing(true)
        switch introState {
        case .emailInput:
            navigationController?.popViewController(animated: true)
        case .pwdInput:
            navigationController?.popViewController(animated: true)
        case .nickname:
            navigationController?.popViewController(animated: true)
        default:
            print("none")
        }
        self.inputTextfield.endEditing(true)
    }
    
    // MARK: Next Button
    
    @objc func didClickedNextButton() {
        presenter?.didClickedRightBarButton(input: inputTextfield.text!, introState: self.introState!, beginState: self.beginState!)
    }
    
    @objc func testNextButton() {
        presenter?.didNextButton(input: inputTextfield.text!, introState: self.introState!, beginState: self.beginState!)
    }
    
    @objc func didClickedCancelButton() {
        switch introState {
        case .emailInput:
            inputTextfield.text = ""
        case .pwdInput:
            inputTextfield.text = ""
        case .nickname:
            inputTextfield.text = ""
        case .none:
            print("none")
        }
    }
}

extension IntroView: IntroViewProtocol {
    func presentNextView() {
        self.invalidLabel.text = ""
        let view = IntroView()
        let presenter = IntroPresenter()
        let interactor = IntroInteractor()
        let remoteDataManager = IntroRemoteDataManager()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.remoteDataManager = remoteDataManager
        
        switch introState {
        case .emailInput:
            view.introState = .pwdInput
            view.beginState = self.beginState == .join ? .join : .signUp
            self.inputTextfield.endEditing(true)
        case .pwdInput:
            view.beginState = self.beginState == .join ? .join : .signUp
            if self.beginState == .join {
                dismiss(animated: true) {
                    print("act something after join")
                }
            } else {
                view.introState = .nickname
                self.inputTextfield.endEditing(true)
            }
        case .nickname:
            self.introState = .nickname
            dismiss(animated: true)
        default:
            print("none")
        }
        
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    func showLoading() {
        LoadingRainbowCat.show(caller: self)
    }
    
    func hideLoading() {
        LoadingRainbowCat.hide(caller: self)
    }
    
    func presentCompleteView() {
        showToast(controller: self, message: "회원가입이 완료되었습니다", seconds: 1) {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    func completeJoin() {
        let view = ViewController()
        view.modalPresentationStyle = .fullScreen
        present(view, animated: true, completion: nil)
    }
    
    func showInvalidEmailAction(message: String) {
        invalidLabel.text = "❌ \(message)"
        invalidGuideAnimation()
    }
    
    func showInvalidPasswordAction() {
        invalidLabel.text = "❌ 비밀번호는 8 ~ 20글자 사이여야 합니다."
        invalidGuideAnimation()
    }
    
    func showInvalidNickNameAction(message: String) {
        invalidLabel.text = "❌ \(message)"
        invalidGuideAnimation()
    }
    
    func showInvalidLoginAction(message: String) {
        invalidLabel.text = "❌ \(message)"
        invalidGuideAnimation()
    }
    
    func invalidGuideAnimation() {
        UIView.animate(withDuration: 0.05) {
            self.invalidLabel.transform = CGAffineTransform(translationX: -10, y: 0)
        } completion: { _ in
            UIView.animate(withDuration: 0.05) {
                self.invalidLabel.transform = CGAffineTransform(translationX: 5, y: 0)
            } completion: { _ in
                UIView.animate(withDuration: 0.05) {
                    self.invalidLabel.transform = CGAffineTransform(translationX: -2.5, y: 0)
                } completion: { _ in
                    UIView.animate(withDuration: 0.05) {
                        self.invalidLabel.transform = CGAffineTransform(translationX: 1.25, y: 0)
                    } completion: { _ in
                        UIView.animate(withDuration: 0.05) {
                            self.invalidLabel.transform = CGAffineTransform(translationX: -0.6125, y: 0)
                        } completion: { _ in
                            UIView.animate(withDuration: 0.05) {
                                self.invalidLabel.transform = CGAffineTransform(translationX: 0, y: 0)
                            } completion: { _ in
                                print("Invalid Response")
                            }
                        }
                    }
                }
            }
        }
    }
}

extension IntroView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        didClickedNextButton()
        return true
    }
}
